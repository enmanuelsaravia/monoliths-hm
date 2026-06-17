#!/bin/dash

cd

if echo -n "$(ls qemu/*)" | grep -q 'iso.iso' > /dev/null && \
	echo -n "$(ls qemu/*)" | grep -q 'img.img' > /dev/null
then
    # Limpiar
    doas pkill dnsmasq 2>/dev/null
    doas ip link delete br0 2>/dev/null
    doas ip link delete tap0 2>/dev/null

    # Bridge
    doas ip link add name br0 type bridge
    doas ip link set br0 up
    doas ip addr add 192.168.99.1/24 dev br0

    # TAP
    doas ip tuntap add dev tap0 mode tap
    doas ip link set tap0 up
    doas ip link set tap0 master br0

    # FORZAR ppp0 como interfaz de internet
    INTERNET_IF='ppp0'
    
    if ! ip link show ppp0 > /dev/null 2>&1; then
        echo '[!] ERROR: La interfaz ppp0 no existe'
        exit 1
    fi
    
    echo "[*] Usando interfaz forzada: $INTERNET_IF"

    # Servidor DHCP - con archivo de leases para detectar IP
    doas cat > /tmp/dnsmasq.conf << EOF
interface=br0
dhcp-range=192.168.99.10,192.168.99.100,255.255.255.0,24h
dhcp-option=3,192.168.99.1
dhcp-option=6,8.8.8.8,1.1.1.1
bind-interfaces
except-interface=lo
dhcp-leasefile=/tmp/dnsmasq.leases
EOF

    doas dnsmasq -C /tmp/dnsmasq.conf

    # Habilitar forwarding
    doas sysctl -w net.ipv4.ip_forward=1
    
    echo "[*] Configurando NAT para $INTERNET_IF con nftables"

    # Limpiar reglas anteriores
    doas nft flush ruleset
    
    # Configurar NAT
    doas nft add table ip nat
    doas nft add chain ip nat prerouting { type nat hook prerouting priority 0 \; }
    doas nft add chain ip nat postrouting { type nat hook postrouting priority 100 \; }
    
    # Regla de masquerading
    doas nft add rule ip nat postrouting ip saddr 192.168.99.0/24 oifname 'ppp0' masquerade
    
    # Configurar FILTER
    doas nft add table ip filter
    doas nft add chain ip filter forward { type filter hook forward priority 0 \; policy drop \; }
    doas nft add chain ip filter input { type filter hook input priority 0 \; }
    
    # Permitir forward
    doas nft add rule ip filter forward iifname 'br0' oifname 'ppp0' accept
    doas nft add rule ip filter forward iifname 'ppp0' oifname 'br0' ct state established,related accept

    # QEMU
    echo '[*] Iniciando QEMU...'
    echo '[*] Espera a que la VM arranque y luego ejecuta en otra terminal:'
    DISABLE_MOUSE='-device isa-serial,chardev=serial0 -chardev stdio,id=serial0'
    DISABLE_MOUSE=''
    qemu-system-x86_64 \
	-machine pc,accel=kvm \
	-nodefaults \
	-name 'Red_interna' \
	-rtc base=utc \
	-smp 2 \
	-m 3788 \
	-k es \
	-netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
	-device e1000,netdev=net0,mac=52:54:00:12:35:08 \
	$DISABLE_MOUSE \
	-vga std \
	-drive file=$HOME/qemu/img.img,format=qcow2,index=0,media=disk \
	-boot c &

    QEMU_PID=$!
    
    # Esperar a que la VM arranque y obtenga IP
    echo '[*] Esperando 50 segundos para que la VM arranque...'
    sleep 50
    
    # Detectar IP de la VM por su MAC address
    VM_MAC='52:54:00:12:35:08'
    VM_IP=$(doas cat /tmp/dnsmasq.leases 2>/dev/null | grep "$VM_MAC" | awk '{print $3}')
    
    if [ -n "$VM_IP" ]; then
        echo "[*] VM detectada con IP: $VM_IP"
        echo "[*] Configurando port forwarding a $VM_IP:8000"
        
        # Configurar port forwarding con la IP real
        doas nft add rule ip nat prerouting tcp dport 8000 dnat to $VM_IP:8000
        doas nft add rule ip filter input tcp dport 8000 accept
        
        echo '[*] ¡Listo! Ahora puedes acceder desde:'
        echo '[*]   - http://localhost:8000'
        echo '[*]   - http://192.168.99.1:8000'
        echo "[*]   - http://$VM_IP:8000 (directo)"
    else
        echo '[!] No se pudo detectar la IP de la VM'
        echo '[!] La VM podría estar usando: 192.168.99.97 (tu IP anterior)'
        echo '[!] O cualquier IP en el rango 192.168.99.10-100'
        echo "[!] Verifica con 'ip addr' dentro de la VM"
    fi

    # Esperar a que QEMU termine
    wait $QEMU_PID

    # Limpiar
    cleanup() {
        echo '[*] Limpiando...'
        doas pkill dnsmasq
        doas nft flush ruleset
        doas ip link delete tap0 2>/dev/null
        doas ip link delete br0 2>/dev/null
        kill $QEMU_PID 2>/dev/null
        exit 0
    }
    trap cleanup INT TERM
fi
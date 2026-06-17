#!/bin/dash

# Asegurar que el PATH incluya rutas de sistema para doas/sudo
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Usar sudo si doas no existe
alias_admin='sudo'
if command -v doas >/dev/null 2>&1; then alias_admin='doas'; fi

# --- NUEVO: Verificación de Dependencias ---
deps='dnsmasq nft sysctl qemu-system-x86_64 ip'
for cmd in $deps; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "[!] Error: '$cmd' no está instalado o no se encuentra en el PATH."
        exit 1
    fi
done

# 1. Verificación de archivos
ISO="$HOME/qemu/iso.iso"
IMG="$HOME/qemu/img.img"
if [ ! -f "$ISO" ] || [ ! -f "$IMG" ]; then
    echo "[!] Error: No se encuentran los archivos en $HOME/qemu/"
    exit 1
fi

# 2. Limpiar rastros previos (Silencioso y seguro)
$alias_admin pkill dnsmasq 2>/dev/null
$alias_admin ip link delete br0 2>/dev/null
$alias_admin ip link delete tap0 2>/dev/null

# 3. Configurar Red (Bridge y TAP)

$alias_admin ip link add name br0 type bridge
$alias_admin ip addr add 192.168.99.1/24 dev br0
$alias_admin ip link set br0 up

$alias_admin ip tuntap add dev tap0 mode tap
$alias_admin ip link set tap0 up
$alias_admin ip link set tap0 master br0

# 4. Detectar interfaz de salida
INTERNET_IF=$(ip route show default | awk '/default/ {print $5}' | head -n1)

if [ -z "$INTERNET_IF" ]; then
    echo '[!] No se detectó interfaz de internet. Abortando.'
    exit 1
fi

# 5. Configurar dnsmasq
$alias_admin touch /tmp/dnsmasq.leases
$alias_admin chmod 666 /tmp/dnsmasq.leases
$alias_admin dnsmasq \
    --interface=br0 \
    --dhcp-range=192.168.99.10,192.168.99.100,24h \
    --dhcp-option=3,192.168.99.1 \
    --dhcp-leasefile=/tmp/dnsmasq.leases \
    --bind-interfaces

# 6. NFTABLES (NAT y Forwarding)
$alias_admin sysctl -w net.ipv4.ip_forward=1
$alias_admin nft flush ruleset
$alias_admin nft -f - <<EOF
table ip nat {
    chain postrouting {
        type nat hook postrouting priority 100; policy accept;
        oifname "$INTERNET_IF" masquerade
    }
    chain prerouting {
        type nat hook prerouting priority 0; policy accept;
        tcp dport 8000 dnat to 192.168.99.10:8000
    }
}
table ip filter {
    chain forward {
        type filter hook forward priority 0; policy accept;
    }
}
EOF

# 7. Ejecutar QEMU
# Se eliminó el & para que el script espere correctamente al proceso en primer plano
echo '[*] Iniciando QEMU... Presiona Ctrl+C en esta terminal para cerrar.'
qemu-system-x86_64 \
    -enable-kvm \
    -cpu host \
    -m 4G \
    -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
    -device e1000,netdev=net0,mac=52:54:00:12:35:08 \
    -drive file="$IMG",format=qcow2 \
    -cdrom "$ISO" \
    -vga std
#!/bin/dash

cd

if echo -n "$(ls qemu/*)" | grep -q 'iso.iso' > /dev/null && \
	echo -n "$(ls qemu/*)" | grep -q 'img.img' > /dev/null
then
    # -nic user,model=e1000,hostfwd=tcp::8080-:80 \\
    #                                    ^host ^VM
    [ ! -f qemu/img.img ] && qemu-img create -f qcow2 qemu/img.img 110G

    qemu-system-x86_64 \
	        -display sdl \
		-enable-kvm \
		-name salida_internet \
		-rtc base=utc \
		-smp 6 \
		-m 8788 \
		-k es \
		-netdev user,id=net0,hostfwd=tcp::8000-:9092 \
		-device e1000,netdev=net0 \
		-cdrom qemu/iso.iso \
		qemu/img.img
fi

#!/bin/dash

cd

if [ -f qemu/img.base.img ]; then
    [ -f qemu/img.img.old ] && mv qemu/img.img.old qemu/img.img.old.old
    [ -f qemu/img.img ] && mv qemu/img.img qemu/img.img.old
    cp qemu/img.base.img qemu/img.img
fi

if echo -n "$(ls qemu/*)" | grep -q 'iso.iso' > /dev/null && \
	echo -n "$(ls qemu/*)" | grep -q 'img.img' > /dev/null
then
    qemu-system-x86_64 \
	-enable-kvm \
	-k es \
	-name user \
	-rtc base=utc \
	-smp 2 \
	-m 3788 \
	-nic user,model=e1000 \
	-cdrom qemu/iso.iso \
	qemu/img.img
fi

cd /vboxguest
mkdir x86 && cd x86 && tar xvjf ../VBoxGuestAdditions-x86.tar.bz2 && cd .. && \
mkdir amd64 && cd amd64 && tar xvjf ../VBoxGuestAdditions-amd64.tar.bz2 && cd .. && \
cd amd64/src/vboxguest-${VBOX_VERSION} && KERN_DIR=/linux-kernel/ make && cd ../../.. && \
cp amd64/src/vboxguest-${VBOX_VERSION}/*.ko /lib/modules/$KERNEL_VERSION-tinycore64 && \
cp x86/lib/VBoxGuestAdditions/mount.vboxsf /b2d/sbin/ && \
depmod -a -b / $KERNEL_VERSION-tinycore64 && \
modprobe vboxsf && \
echo "vboxsf successfully installed"

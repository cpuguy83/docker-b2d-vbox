FROM boot2docker/boot2docker
ENV VBOX_VERSION 4.3.12
RUN apt-get update -qq && apt-get install -y p7zip-full
RUN mkdir -p /vboxguest && \
    cd /vboxguest && \
    curl -L -o vboxguest.iso http://download.virtualbox.org/virtualbox/${VBOX_VERSION}/VBoxGuestAdditions_${VBOX_VERSION}.iso && \
    7z x vboxguest.iso -ir'!VBoxLinuxAdditions.run' && \
    sh VBoxLinuxAdditions.run --noexec --target .
ADD mkvbox.sh /mkvbox.sh
CMD /mkvbox.sh

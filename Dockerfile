FROM ubuntu:20.04

# updates and install apt-get packages
RUN apt-get update
RUN apt-get -y full-upgrade
RUN apt-get -y install kpartx qemu binfmt-support \
    qemu-user-static libdevmapper-dev

# Copy .img file
COPY ./2022-09-22-raspios-buster-armhf-lite.img /usr/src

WORKDIR /usr/src

# Set Up the Loopback Devices
RUN kpartx -av 2022-09-22-raspios-buster-armhf-lite.img

# (Optional) Check and Possibly Resize the Raspbian Filesystem
RUN e2fsck -f /dev/mapper/loop10p2
RUN resize2fs /dev/mapper/loop10p2

# Mount the Loopback Filesystems
RUN mkdir /mnt/pi_image
RUN ls /dev/mapper
#RUN mount /dev/mapper/loop10p2 /mnt/pi_image
#RUN mount /dev/mapper/loop10p1 /mnt/pi_image/boot

# Prepare for Chroot
#RUN cp /usr/bin/qemu-arm-static /mnt/pi_image/usr/bin

#FROM scratch

#COPY --from=0 /mnt/pi_image /bin/bash

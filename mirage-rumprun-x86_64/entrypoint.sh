#!/bin/sh

cat <<EOF
To try an example MirageOS Rump Kernel,

$ git clone https://github.com/mirage/mirage-skeleton \\
    && cd mirage-skeleton                             \\
    && git checkout mirage-dev
$ cd mirage-skeleton/console
$ mirage configure -t rumprun && make depend && make

To run the resulting image on Linux using KVM:

$ rumprun-bake hw_virtio mir-console.bin mir-console
$ rumprun kvm -i ./mir-console.bin

Or, to run on OSX using qemu:

$ sudo apt-get install -y qemu
$ chmod 755 rumprun-qemu
$ rumprun-qemu <image.bin> <port-to-expose>

EOF

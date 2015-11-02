#!/bin/sh

cat <<EOF
To try an example MirageOS Rump Kernel,

$ git clone https://github.com/mirage/mirage-skeleton \\
    && cd mirage-skeleton                             \\
    && git checkout mirage-dev
$ cd console
$ mirage configure -t rumprun && make depend && make
$ cd ../stackv4
$ mirage configure -t rumprun && make depend && make

To run the resulting image on Linux using KVM:

$ rumprun-bake hw_virtio mir-console.bin mir-console
$ rumprun kvm -i ./mir-console.bin

Or, to run on OSX using qemu:

$ sudo apt-get install -y qemu
$ chmod 755 rumprun-qemu
$ rumprun-qemu <rumprun-image.bin> <TCP-port-to-expose>

EOF
exec /bin/bash

#!/bin/bash
PLATFORM=$(basename /usr/local/rumprun/bin/*-rumprun-*gcc |sed -e s/-gcc//)
cat <<EOM

Welcome.

The rumprun toolchain for '${PLATFORM}' has been installed in
/usr/local/rumprun.

You might want to try:

\$ ${PLATFORM}-gcc -o hello hello.c
\$ rumpbake hw_virtio hello.bin hello

EOM
exec /bin/bash

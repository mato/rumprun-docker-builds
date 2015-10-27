# This container builds the rumprun toolchain for hw/x86_64
FROM mato/rumprun-buildbase-debian
MAINTAINER Martin Lucina <martin@lucina.net>

# All builds are done as non-root.
USER build
WORKDIR /build

# Clone latest rumprun master.
RUN git clone git://github.com/rumpkernel/rumprun

# Init submodules.
WORKDIR /build/rumprun
RUN git submodule init && git submodule update

# Build the toolchain.
RUN ./build-rr.sh -d /usr/local/rumprun hw build

# Install the toolchain.
RUN sudo ./build-rr.sh -d /usr/local/rumprun hw install
ENV PATH /usr/local/rumprun/bin:$PATH

# Delete the toolchain source, thus reducing the image size.
WORKDIR /build
RUN rm -rf /build/rumprun

# Install a "Hello, World" and build it to verify that the toolchain works.
COPY hello.c /build/
RUN x86_64-rumprun-netbsd-gcc -o hello hello.c && \
    rumpbake hw_virtio hello.bin hello && \
    rm -f hello.bin hello

# Install a welcome script to give the user a hint about what to do next.
# XXX Can't we just update .profile here and run a login shell?
COPY entrypoint.sh /build/
# XXX Docker Hub fails this with "chmod: changing permissions of '/build/entrypoint.sh: Operation not permitted"
# RUN chmod +x /build/entrypoint.sh
CMD ["/bin/bash", "/build/entrypoint.sh"]

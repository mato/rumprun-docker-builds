# This container builds the rumprun toolchain for hw/i686
FROM mato/rumprun-buildbase-debian
MAINTAINER Martin Lucina <martin@lucina.net>

# All builds are done as non-root.
USER build
WORKDIR /build

# Build and install the toolchain.
# This must be done in a single layer to avoid ballooning the image size,
# hence the series of "&&".
# It'd be nice if Docker had support for controlling when layers are created,
# wouldn't it? See
# http://jasonwilder.com/blog/2014/08/19/squashing-docker-images/ for possible
# solutions and https://github.com/docker/docker/issues/332 for bikeshed.
RUN git clone https://github.com/rumpkernel/rumprun && \
    cd /build/rumprun && \
    git submodule init && git submodule update && \
    ./build-rr.sh -d /usr/local/rumprun hw build -- -F ACFLAGS=-m32 -F ACLFLAGS=-march=i686 && \
    sudo ./build-rr.sh -d /usr/local/rumprun hw install -- -F ACLFLAGS=-m32 -F ACLFLAGS=-march=i686 && \
    rm -rf /build/rumprun

# Install a "Hello, World" and build it to verify that the toolchain works.
ENV PATH /usr/local/rumprun/bin:$PATH
COPY hello.c /build/
RUN i486-rumprun-netbsdelf-gcc -o hello hello.c && \
    rumprun-bake hw_virtio hello.bin hello && \
    rm -f hello.bin hello

# Install a welcome script to give the user a hint about what to do next.
# XXX Can't we just update .profile here and run a login shell?
COPY entrypoint.sh /build/
# XXX Docker Hub fails this with "chmod: changing permissions of '/build/entrypoint.sh: Operation not permitted"
# RUN chmod +x /build/entrypoint.sh
CMD ["/bin/bash", "/build/entrypoint.sh"]

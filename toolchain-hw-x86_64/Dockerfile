# This container builds the rumprun toolchain for hw/x86_64
FROM mato/rumprun-buildbase-debian
MAINTAINER Martin Lucina <martin@lucina.net>
RUN mkdir -p /src/rumprun && chown daemon /src/rumprun
USER daemon
WORKDIR /src/rumprun
RUN git clone git://github.com/rumpkernel/rumprun . && \
        git submodule init && git submodule update
RUN ./build-rr.sh hw

FROM mato/rumprun-toolchain-hw-x86_64
MAINTAINER Richard Mortier <mort@cantab.net>

USER build
WORKDIR /build

# set some OPAM options
ENV OPAMYES 1
ENV OPAMJOBS 4

# install `opam`; add `m4` as `ocamlfind` depends on it but has no depext
RUN sudo apt-get install -y m4 opam
# initialise OPAM
RUN opam init --verbose --auto-setup --dot-profile=~/.bashrc

# switch to specific `ocaml` version supported
RUN opam switch 4.02.1 && eval $(opam config env)

# add rumprun opam repo
RUN opam repository add rumprun git://github.com/mor1/opam-rumprun
# install `ocaml-rumprun`
RUN RUMPRUN_PLATFORM=x86_64-rumprun-netbsd opam install ocaml-rumprun

# pin and install mirage.2.5.0+rumprun
RUN opam pin add mirage 2.5.0+rumprun && opam install mirage

# convenience: quick test of rumpkernels inside VirtualBox on OSX
RUN sudo apt-get install -y qemu
ADD rumprun-qemu rumprun-qemu
RUN sudo chmod 755 rumprun-qemu

# clone and checkout the samples
RUN git clone https://github.com/mirage/mirage-skeleton \
    && cd mirage-skeleton                               \
    && git checkout mirage-dev

CMD ["bash"]

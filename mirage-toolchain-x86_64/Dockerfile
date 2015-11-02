FROM mato/rumprun-toolchain-hw-x86_64
MAINTAINER Richard Mortier <mort@cantab.net>

# set some OPAM options
ENV OPAMYES=1 OPAMJOBS=4

# install `opam`; add `m4` as `ocamlfind` depends on it but has no depext
RUN apt-get update                                      \
    && DEBIAN_FRONTEND=noninteractive                   \
       apt-get install -q -y --no-install-recommends    \
         m4 opam                                        \
    && apt-get clean

# initialise OPAM
RUN opam init --verbose --auto-setup --dot-profile=~/.bashrc

# switch to specific `ocaml` version supported
RUN opam switch 4.02.1 && eval $(opam config env)

# add rumprun opam repo
RUN opam repository add rumprun https://github.com/mato/opam-rumprun
# install `ocaml-rumprun`
RUN RUMPRUN_PLATFORM=x86_64-rumprun-netbsd opam install ocaml-rumprun

# pin and install mirage.2.5.0+rumprun
RUN opam pin add mirage 2.5.0+rumprun && opam install mirage

# enter the mirage...
COPY entrypoint.sh /build/
CMD ["/bin/bash", "/build/entrypoint.sh"]

FROM debian:latest
MAINTAINER Martin Lucina <martin@lucina.net>
# ca-certificates is required for git clone https://... to work
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates build-essential git && \
    apt-get clean

FROM debian:bookworm
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && \ 
    apt upgrade -y && \ 
    apt install -y easy-rsa
RUN ln -s /usr/share/easy-rsa/easyrsa /usr/bin/easyrsa

ARG USERNAME=""
ARG USERID=""
ARG USERDIR=/home/easyrsa
ARG WORKDIR="$USERDIR/ca"

RUN useradd -m -d "$USERDIR" -u "$USERID" -s /bin/bash "$USERNAME"
USER "$USERNAME"
WORKDIR "$WORKDIR"

ENTRYPOINT [ "/bin/bash", "easyrsa_manager.sh" ]

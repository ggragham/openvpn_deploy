FROM debian
RUN apt update -y && \ 
    apt upgrade -y && \ 
    apt install -y easy-rsa
RUN ln -s /usr/share/easy-rsa/easyrsa /usr/bin/easyrsa
RUN useradd -m -s /bin/bash easyrsa
USER easyrsa
RUN mkdir /home/easyrsa/ca
WORKDIR /home/easyrsa/ca
ENTRYPOINT [ "/bin/bash", "ersa.sh" ]

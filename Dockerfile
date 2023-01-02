# Great stuff taken from: https://github.com/rastasheep/ubuntu-sshd

FROM ubuntu:18.04
MAINTAINER Aleksandar Diklic "https://github.com/rastasheep"

RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN useradd --user-group --create-home --system mogenius

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

# PLEASE CHANGE THAT AFTER FIRST LOGIN
RUN echo 'mogenius:mogenius' | chpasswd

CMD ["/usr/sbin/sshd", "-D", "-e"]

RUN apt-get update
RUN apt install -y curl
RUN wget https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh
RUN chmod +x install-release.sh
RUN ./install-release.sh

RUN wget https://raw.githubusercontent.com/chenchen65536/ubuntu-18.04/main/cloudflare.pem?token=GHSAT0AAAAAAB46YM6RT3P3A3HA3S35IDSCY5TAC3Q -O /usr/local/etc/v2ray/cloudflare.pem
RUN wget https://raw.githubusercontent.com/chenchen65536/ubuntu-18.04/main/cloudflare.key?token=GHSAT0AAAAAAB46YM6QBHBSABED57ZX63NQY5TAF6Q -O /usr/local/etc/v2ray/cloudflare.key
RUN wget https://raw.githubusercontent.com/chenchen65536/ubuntu-18.04/main/config.json?token=GHSAT0AAAAAAB46YM6QQM43RD3WQW7V7AFUY5TAGVA -O /usr/local/etc/v2ray/config.json

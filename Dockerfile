FROM alpine:latest

RUN \
 apk add --no-cache --upgrade \
  shadow \
	openssh-server

RUN \
  ssh-keygen -A && \
  useradd -s /bin/false -c "Pseudo user for ssh tunnel" -m -r tunnel -p "*" && \
  mkdir /home/tunnel/.ssh

COPY authorized_keys /home/tunnel/.ssh
COPY sshd_config /etc/ssh/

RUN \
  chown -R tunnel /home/tunnel/.ssh && \
  chmod -R og-rwX /home/tunnel/.ssh && \
  rm -rf \
	  /tmp/*

CMD /usr/sbin/sshd -D -e -p 22

FROM ubuntu

RUN apt update && apt install git git-lfs python3-full python3-pip -y && \
  echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

ADD *.sh /
ADD py-scripts /py-scripts
ADD action.yml /

ENTRYPOINT ["/entrypoint.sh"]

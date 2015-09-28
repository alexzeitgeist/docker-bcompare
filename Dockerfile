# vim:set ft=dockerfile:

# VERSION 1.1
# AUTHOR:         Alexander Turcic <alex@zeitgeist.se>
# DESCRIPTION:    Beyond Compare in a Docker container
# TO_BUILD:       docker build --rm -t zeitgeist/docker-bcompare .
# SOURCE:         https://github.com/alexzeitgeist/docker-bcompare

# Pull base image.
FROM debian:jessie
MAINTAINER Alexander Turcic "alex@zeitgeist.se"

ENV BCOMPARE_URL http://www.scootersoftware.com/bcompare-4.1.1.20615_amd64.deb

# Install dependencies.
RUN \
  apt-get update && \
  apt-get install -y wget && \
  wget "${BCOMPARE_URL}" -O bcompare.deb && \
  apt-get purge -y --auto-remove wget && \
  { dpkg -i bcompare.deb || true; } && \
  rm bcompare.deb && \
  apt-get install -y -f && \
  rm -rf /var/lib/apt/lists/*

# Setup user environment. Replace 1000 with your user / group id.
RUN \
  export uid=1000 gid=1000 && \
  groupadd --gid ${gid} user && \
  useradd --uid ${uid} --gid ${gid} --create-home user

USER user
WORKDIR /home/user
VOLUME /home/user

CMD ["/usr/bin/bcompare"]

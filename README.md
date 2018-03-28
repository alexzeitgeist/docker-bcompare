# zeitgeist/docker-bcompare

[Beyond Compare 4](http://www.scootersoftware.com/) in a Docker container.

## Requirements

* [Docker](https://www.docker.com/) 1.6+ (previous versions may work fine, but I haven't tried)
* An X11 socket

## Installation

Get the [trusted build on the docker hub](https://registry.hub.docker.com/u/zeitgeist/docker-bcompare/):

```bash
$ docker pull zeitgeist/docker-bcompare
```

or download and compile the source yourself from Github:

```bash
$ git clone https://github.com/alexzeitgeist/docker-bcompare.git
$ cd docker-bcompare
$ docker build -t zeitgeist/docker-bcompare .
```

## Usage

```bash
$ docker run --rm \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -e DISPLAY=unix$DISPLAY \
  zeitgeist/docker-bcompare
```

With persistent storage to work with files on the host:

Create a folder on the host, e.g. ${HOME}/bcompare. Then map it like this:

```bash
$ docker run --rm \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -e DISPLAY=unix$DISPLAY \
  -v "${HOME}/bcompare":"/home/user" \
  zeitgeist/docker-bcompare
```

You can create a shell script for comparing directly two files/folder by running 'script f1 f2':

```bash
#!/bin/sh

FILES_COMPARE="$@"

docker run -it --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -e DISPLAY=unix$DISPLAY \
    -e FILES="${FILES_COMPARE}" \
    -v $(pwd):"/home/user" \
    zeitgeist/docker-bcompare \
    bash -c 'cd /home/user ; bcompare $FILES'
```

## OS X

For running in OS X, you can create a shell script like this:

```bash
#!/bin/sh

ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}') 
xhost + $ip

docker run -it --rm \
    -e DISPLAY=$ip:0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v "${HOME}/bcompare":"/home/user" \
    zeitgeist/docker-bcompare 
```

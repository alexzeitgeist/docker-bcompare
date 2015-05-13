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

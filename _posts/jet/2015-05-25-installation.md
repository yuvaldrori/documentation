---
title: Installation
layout: page
weight: 98
tags:
  - jet
  - introduction
  - installation
categories:
  - jet
---

## Prerequisites

You need to have Docker installed on your machine, please see the below commands for the most common ways to install it. Head over to the [Docker Installation Guides](https://docs.docker.com/installation/#installation) for more complete guides.

### Mac OS X

We recommend using [Docker Machine](https://docs.docker.com/machine/) if you're using OS X. While it is still in beta at the moment, it is what Docker Inc is pushing to create Docker hosts on various systems.

```bash
brew install docker-machine
docker-machine create -d virtualbox dev
```

See the [documentation on Docker.com](https://docs.docker.com/machine/) for more details.

### Linux


## Jet

```bash
curl -L https://github.com/codeship/codeship-tool/raw/master/downloads/darwin_amd64/jet > /usr/local/bin/docker-machine
$ chmod +x /usr/local/bin/docker-machine
```

## Docker configuration

`DOCKER_HOST` must be set. `DOCKER_TLS_VERIFY` and `DOCKER_CERT_PATH` are also respected in the same way as with the official Docker client.

If you are on OS X or Linux, running the following command will set those variables (if you already have Docker Machine installed, as per the prerequisites).

```bash
eval $(docker-machine env dev)
```

Once you have _Jet_ installed, simply run `jet help` for the main help page.

```bash
$ jet help
Usage:
  jet [command]

Available Commands:
  generate
  encrypt
  decrypt
  steps
  run
  run-multiple
  load
  help         Help about any command

Flags:
  -h, --help=false: help for jet

Use "jet help [command]" for more information about a command.
```

By default, _Jet_ uses your current directory for the context, but this can be changed with the `--dir` flag.

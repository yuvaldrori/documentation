---
title: Jet Installation
layout: page
weight: 75
tags:
  - docker
  - jet
  - introduction
  - installation
  - running locally
categories:
  - docker
---

<div class="info-block">
These commands are only applicable if you want to run the `jet` binary locally. If you only want to run your builds via the Codeship website you can skip these steps.
</div>

* include a table of contents
{:toc}

## Prerequisites

In order to run the _Jet_ binary on your computer you need to have Docker installed and configured. We recommend you follow the guides regarding [Docker Machine](https://docs.docker.com/machine/) to get both the docker binary installed as well as a Docker host configured.

Please note, that, similar to Jet, Docker Machine itself is still in Beta state and things are likely to change.

## Jet

If you are running Linux or OS X, please execute the following two commands on a terminal (tested with bash)

### OS X
```bash
curl -L https://github.com/codeship/tool/releases/download/v1/default.jet-darwin_amd64 > /usr/local/bin/jet
chmod +x /usr/local/bin/jet
```

### Linux
```bash
curl -L https://github.com/codeship/tool/releases/download/v1/default.jet-linux_amd64 > /usr/local/bin/jet
chmod +x /usr/local/bin/jet
```

Once this is done you can check that _Jet_ is working by running `jet help`. This will print output similar to the following.

```
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

## Docker Configuration

`DOCKER_HOST` must be set. `DOCKER_TLS_VERIFY` and `DOCKER_CERT_PATH` are respected in the same way as with the official Docker client.

If you installed and configured your Docker environment via Docker Machine (and you are on OS X or Linux) and named the environment _dev_, running the following command will set those variables.

```bash
eval $(docker-machine env dev)
```

---
title: Installation
layout: page
weight: 98
tags:
  - jet
  - introduction
  - installation
  - running locally
categories:
  - jet
---

<div class="info-block">
These commands are only applicable if you want to run the `jet` binary locally. If you only want to run your builds via the Codeship website you can skip these steps.
</div>


## Prerequisites

In order to run the _Jet_ binary on your computer you need to have Docker installed and configured. We recommend you follow the guides regarding [Docker Machine](https://docs.docker.com/machine/) to get both the docker binary installed as well as a Docker host configured.

Please note, that, similar to Jet, Docker Machine itself is still in Beta state and things are likely to change.

## Jet

If you are running Linux or OS X, please execute the following two commands on a terminal (tested with bash)

```bash
git clone https://github.com/codeship/codeship-tool.git
sudo ln -s "$(pwd)/codeship-tool/downloads/$(uname -s | tr '[:upper:]' '[:lower:]')_amd64/jet" "/usr/local/bin/"
```

Once this is done you can check that _Jet_ is working by running `jet help`. This will print output similar to the following.

```
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

For updating to a newer version of the tool, simply pull from the remote repository.

## Docker Configuration

`DOCKER_HOST` must be set. `DOCKER_TLS_VERIFY` and `DOCKER_CERT_PATH` are also respected in the same way as with the official Docker client.

If you installed and configured your Docker environment via Docker Machine (and you are on OS X or Linux), running the following command will set those variables.

```bash
eval $(docker-machine env dev)
```

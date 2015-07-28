---
title: Jet Release Notes
layout: page
weight: 5
tags:
  - docker
  - jet
  - release notes
categories:
  - docker
---

## Version 0.3

### 0.3.5

* Fixed a bug with labels not being parsed correctly.

### 0.3.4

* Changed how images are built. We'll use the project directory as the build context, instead of the `Dockerfile` directory.

### 0.3.3

* Added a `jet version` subcommand.
* Fixed the Docker build context.

### 0.3.2

* Fixed a bug regarding Docker volumes.

### 0.3.1

* Fixed a minor bug regarding parsing of YAML files.

### 0.3.0

* Added support for pushing Docker images. See [our Docker push tutorial]({{ site.baseurl }}{% post_url docker/tutorials/2015-07-03-docker-push %}) to get started.

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

## Version 0.4

### 0.4.0

* Jet now builds missing images when pushing and you no longer need to run dummy commands to force services to build in order to push them
* Jet reads services/compose file more in line with `docker-compose`.

    Previously in relation to service Dockerfile paths and the build declaration `jet` and `docker-compose` would differ. `docker-compose` would allow you to specify a context directory for the entire build, not just the location of the Dockerfile, while jet would enforce using the top level directory as the context directory for the entire build.

    Now you can specify a context directory for building an image by using the `build: custom_directory` tag in your services file, which should match `docker-compose` in behavior.

## Version 0.3

### 0.3.8

* Added support for using private repositories as base images.

### 0.3.7

* Added the `image_tag` field for `push` steps. This can be either a hardcoded script or a golang [`Template` object](http://golang.org/pkg/text/template/) referencing a number of variables. Please see the [push steps]({{ site.baseurl }}{% post_url docker/2015-05-25-steps %}#push-steps) documentation for the available variables.

### 0.3.6

* Fixed an internal bug with the integration for the hosted beta on [codeship.com](https://codeship.com)

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

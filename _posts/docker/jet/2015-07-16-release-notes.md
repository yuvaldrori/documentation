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

<div class="info-block">
Missing versions only improved the integration with our hosted platform and have no user facing changes / bug fixes.
</div>

## Version 0.9

### 0.9.0

* Fixing caching pull bug

    This change extends the pull errors we discard during a cache pull. All pull errors relating to the image not being found are discarded. This change makes that selection process more compatible with different registries.

* Updating Jet to pull the image cache before building

    Jet will now determine an image cache to pull and use as a build cache during docker image builds. If an image exists with a tag "codeship-cache-$CI_BRANCH", it will be pulled and provide faster builds. Jet will also automatically push to this cache when an image is pushed.

## Version 0.8

### 0.8.2

* Fixing AES key panic

    Jet will now error when no AES key is found, but an encrypted dockercfg file is used.

### 0.8.1

* Fixing a bug with base images from private registries.

    This change adds support to use a image from a private registry as for the `FROM` directive in a Dockerfile.

### 0.8.0

* Changes to the default encryption key location

    Instead of using the key from `${HOME}/.codeship/keys/aes/key.key` the default location is now `codeship.aes` in your project root directory.

## Version 0.7

### 0.7.16

*  Fixing service load bug

    This change resolves an issue where links and volumes were not loading correctly.

### 0.7.12

* Fixing a bug with detecting duplicate image building

    This change fixes a bug where jet would give false positives when detecting cases where images are being rebuilt.

### 0.7.11

* Fixing a bug with image building

    This change fixes a bug where a single image was being build multiple times for a specific set of steps. All steps now use the same image which is built once.

### 0.7.10

* Updating Commit build environment variable to CommitID

    This change renames `Commit` to `CommitID` to bring Jet in line with other CI systems. The commit ID/SHA can now be accessed via `{% raw %}{{ .CommitID }}{% endraw %}` for push tags and via the `CI_COMMIT_ID` environment variable within containers.

### 0.7.7

* Fixing image uniqueness bug

    This fixes a bug where image uniqueness checks were causing builds to error.

### 0.7.4

*  Jet run errors correctly

    Jet run will now exit if an error occurs while starting services.

### 0.7.2

* Already built error

    Jet will now return an error if multiple services try to build the same image name.

## Version 0.5

### 0.5.1

* Exposing Build Environment Variables

    The same variables used for Docker [image tagging]({{ site.baseurl }}{% post_url docker/2015-05-25-steps %}#push-steps) will now be available as environment variables in any containers running steps. We have also extended what variables are available. Here is a complete list:

    * ProjectID: `CI_PROJECT_ID`
    * BuildID: `CI_BUILD_ID`
    * RepoName: `CI_REPO_NAME`
    * Commit: `CI_COMMIT`
    * CommitMessage: `CI_COMMIT_MESSAGE`
    * CommitterName: `CI_COMMITTER_NAME`
    * CommitterEmail: `CI_COMMITTER_EMAIL`
    * CommitterUsername: `CI_COMMITTER_USERNAME`
    * Branch: `CI_BRANCH`
    * StringTime: `CI_STRING_TIME`
    * Timestamp: `CI_TIMESTAMP`
    * Ci: `CI` (set to `true`)
    * CiName: `CI_NAME` (set to `codeship`)

    For tagging within push steps the following variables will also be available, and the resulting template will be stripped of any invalid characters.

    * StepName
    * ServiceName
    * ImageName

* Push Retries

    We have enabled a simple retry mechanism when pushing docker images. Often simultaneous image pushes cause problems, so when an image push step receives one of several listed errors from the registry, the push will be attempted again. You may see some duplicate logging where push steps ran several times due to registry errors.

### 0.5.0

* Supporting `.local` DNS

    Jet now comes in two flavours, statically linked and dynamically linked. With the dynamic version you can take advantage of local network resources like `.local` DNS entries. The statically linked version will have a much better time running in reduced environments like scratch containers.

* Enforcing shared services

    Each step will now have one instance of a service, shared via the compose specification listed in your services files. Previously this created one container instance for each service using that dependency.

* Fixing container naming bug

    Invalid characters are now stripped out of auto-generated container names

* Capturing more errors

    Jet will also pick up link container creation errors

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

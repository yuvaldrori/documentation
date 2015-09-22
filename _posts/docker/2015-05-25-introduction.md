---
title: Welcome to Docker on Codeship
layout: page
weight: 95
tags:
  - docker
  - introduction
categories:
  - docker
---

Welcome to our Docker Infrastructure, the new way to run your tests on Codeship. This tool is designed with the goal to allow your various environments (e.g. _production_ and _staging_ deployment as well as local development) to have perfect parity with the environment on Codeship you run your tests in. This is achieved by using Docker containers for defining and managing environments.

<div class="info-block">
**Note**

- We only support git based repositories on GitHub and BitBucket. **We do not support Mercurial based repositories on BitBucket right now.**
</div>

_Docker Infrastructure_ implements two main functions:

- It replicates and replaces some of the functionality of [Docker Compose](https://docs.docker.com/compose/).
- It allows you to define your CI and CD steps and run those the same way locally as within the Codeship environment.

For this reason we introduce two new concepts.

- [Services]({{ site.baseurl }}{% post_url docker/2015-05-25-services %}) specify a Docker image, plus accompanying configuration, same as you would do with _Docker Compose_.
- [Steps]({{ site.baseurl }}{% post_url docker/2015-05-25-steps %}) specify what to run on those services.

So, to get up and running, please [install Jet locally]({{ site.baseurl }}{% post_url docker/jet/2015-05-25-installation %}) and follow our [tutorial]({{ site.baseurl }}{% post_url docker/2015-06-10-getting-started %}) to get your first project working with _Jet_.

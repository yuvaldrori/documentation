---
title: Welcome to Docker on Codeship
layout: page
weight: 99
tags:
  - docker
  - introduction
categories:
  - docker
---

Welcome to our Docker Infrastructure Beta, the new way to run your tests on Codeship. This tool is designed with the goal to allow your various environments (e.g. _production_ and _staging_ deployment as well as local development) to have perfect parity with the environment on Codeship you run your tests in. This is achieved by using Docker containers for defining and managing environments.

<div class="info-block">
**Notes during the Beta**

- The **database** for the Codeship website integration **will be wiped regularly**. Don't rely on the beta for CI / CD for your production environments.
- **Encrypted environment variables are not available** for builds triggered via the Codeship website.
- We **strongly** recommend **forking the repositories** you want to try during the beta, as you can't configure the same repository twice on Codeship.
</div>

_Docker Infrastructure (Beta)_ implements two main functions:

- It replicates and replaces some of the functionality of [Docker Compose](https://docs.docker.com/compose/).
- It allows you to define your CI and CD steps and run those the same way locally as within the Codeship environment.

For this reason we introduce two new concepts.

- [Services]({{ site.baseurl }}{% post_url docker/2015-05-25-services %}) specify a Docker image, plus accompanying configuration, same as you would do with _Docker Compose_.
- [Steps]({{ site.baseurl }}{% post_url docker/2015-05-25-steps %}) specify what to run on those services.

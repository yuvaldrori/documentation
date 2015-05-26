---
title: Welcome to Jet
layout: page
weight: 99
tags:
  - jet
  - introduction
categories:
  - jet
---

<div class="info-block">
**Notes during the Beta**

- The database for the Codeship website integration will be wiped regularly. Don't rely on the Jet Beta for CI / CD for your production environments.
- Encrypted environment variables are not available for builds triggered via the Codeship website.
</div>

Welcome to `jet`, the new way to run your tests on Codeship. _Jet_ is designed with the goal to allow your various environments (e.g. _production_ and _staging_ deployment as well as local development) to have perfect parity with the environment on Codeship you run your tests in. This is achieved by using Docker containers for defining and managing environments.

_Jet_ implements two main functions:

- It replicates and replaces some of the functionality of [Docker Compose](https://docs.docker.com/compose/).
- It allows you to define your CI and CD steps and allows you to run those the same way locally as within the Codeship environment.

For this reason we introduce two new concepts.

- _Services_ specify a Docker image, plus accompanying configuration, same as you would do with _Docker Compose_.
- _Steps_ specify what to run on those services.

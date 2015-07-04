---
title: "Tutorial: Pushing to a remote registry"
layout: page
weight: 45
tags:
  - docker
  - tutorial
  - push
  - registry
categories:
  - docker
---

## Pushing to Quay.io

**Prerequisites:** You will need to have a robot account for your Quay repository. Please see the documentation on [Robot Accounts](http://docs.quay.io/glossary/robot-accounts.html) for Quay.io on how to set it up for your repository.

* Log in to Quay via docker:

```bash
docker login -e="." -u="<username>+<>" -p="<token>" quay.io
```

* Configure your `codeship-services.yml` file. Example:

```yaml
app:
  build:
    image: username/reponame
    dockerfile_path: Dockerfile
```

* Configure your `codeship-steps.yml` file. Make sure your `image_name` is identical to the one one on your `codeship-services.yml`. Point `registry` to your image repository’s url

```yaml
- service: app
  type: push
  image_name: username/reponame
  registry: quay.io/username/reponame
  encrypted_dockercfg_path:
```

As always, feel free to contact [support@codeship.com](mailto:support@codeship.com) if you have any questions.

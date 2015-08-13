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

* include a table of contents
{:toc}

## Pushing to a locally running registry

Please see the [example in the codeship-tool examples repository](https://github.com/codeship/codeship-tool-examples/tree/master/16.docker_push) for how to run a registry during the build process and push a new image to this registry.

## Pushing to the Docker Hub

* Get the AES encryption key from the _General_ settings page of your Codeship project and save it to your repository as `codeship.key` (adding it to the `.gitignore` file is a good idea).

* Login to the Docker Hub locally and save the encrypted credentials file to your repository.

```bash
docker login
# follow the onscreen instructions
# ...
jet encrypt --key-path=codeship.key ${HOME}/.docker/config.json dockercfg.encrypted
git add dockercfg.encrypted
git commit -m "Adding encrpyted credentials for docker push"
```

* Configure your `codeship-services.yml` file. It will probably look similar to the following:

```yaml
app:
  build:
    image: username/repository_name
    dockerfile_path: Dockerfile
```

* Configure your `codeship-steps.yml` file. Make sure your `image_name` is identical to the one one on your `codeship-services.yml` and includes the registry as well.

    If you don't want to push the image for each build, add a `tag` entry to the below step and it will only be run on that specific branch or git tag.

```yaml
- service: app
  type: push
  image_name: username/repository_name
  registry: https://index.docker.io/v1/
  encrypted_dockercfg_path: dockercfg.encrypted
```

* Commit and push the changes to your remote repository, head over to [Codeship](https://codeship.com/), watch your build and then check out your new image!

## Pushing to Quay.io

**Prerequisites:** You will need to have a robot account for your Quay repository. Please see the documentation on [Robot Accounts](http://docs.quay.io/glossary/robot-accounts.html) for Quay.io on how to set it up for your repository.

* Once you have configured the robot account, download the `.dockercfg` file for this account, by heading over to the _Robots Account_ tab in your settings, clicking the gear icon, selecting _View Credentials_ and hitting the download button.

    Save the file as `dockercfg` in your repository (you'll probably want to add it to the `.gitignore` file as well).

* Get the AES encryption key from the _General_ settings page of your Codeship project and save it to your repository as `codeship.key` (again, adding it to the `.gitignore` file is a good idea).

* Encrypt the credentials for accessing Quay.io by running the following command and commit the encrypted file to your repository.

```bash
jet encrypt --key-path=codeship.key dockercfg dockercfg.encrypted
git add dockercfg.encrypted
git commit -m "Adding encrpyted credentials for docker push"
```

* Add the robot user to the Quay.io repository with the appropriate permissions (at least _Write_).

* Configure your `codeship-services.yml` file. It will probably look similar to the following:

```yaml
app:
  build:
    image: quay.io/username/repository_name
    dockerfile_path: Dockerfile
```

* Configure your `codeship-steps.yml` file. Make sure your `image_name` is identical to the one one on your `codeship-services.yml` and includes the registry as well.

    If you don't want to push the image for each build, add a `tag` entry to the below step and it will only be run on that specific branch or git tag.

```yaml
- service: app
  type: push
  image_name: quay.io/username/repository_name
  registry: quay.io
  encrypted_dockercfg_path: dockercfg.encrypted
```


* Commit and push the changes to your remote repository, head over to [Codeship](https://codeship.com/), watch your build and then check out your new image!

As always, feel free to contact [beta@codeship.com](mailto:beta@codeship.com) if you have any questions.

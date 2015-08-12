---
title: "Tutorial: Using private base images"
layout: page
weight: 45
tags:
  - docker
  - tutorial
  - pull
  - registry
categories:
  - docker
---

## Using private images in your builds

`jet` does support using private Docker images as base images for your containers. Similar to [pushing images]({{ site.baseurl }}{% post_url docker/tutorials/2015-07-03-docker-push %}) you need to save your encrypted `.dockercfg` file in the repository and reference it for any step using private base images (or to groups of steps).

## Configuring a build with a private base image

* Get the AES encryption key from the _General_ settings page of your Codeship project and save it to your repository as `codeship.key` (adding it to the `.gitignore` file is a good idea).

* Getting the `.dockercfg`

    * For Docker Hub, Login locally and mv the credentials file to your repository.

```bash
docker login
# follow the onscreen instructions
# ...
mv ${HOME}/.docker/config.json dockercfg
```

*
    * For Quay.io

        * First configure a [robot account](http://docs.quay.io/glossary/robot-accounts.html)
        * Once you have configured the robot account, download the `.dockercfg` file for this account, by heading over to the _Robots Account_ tab in your settings, clicking the gear icon, selecting _View Credentials_ and hitting the download button.

            Save the file as `dockercfg` in your repository

* Add the unencrypted file to your `.gitignore` file

```bash
echo "dockercfg" >> .gitignore
```

* Encrypt the credentials and add it to the repository

```bash
jet encrypt --key-path=codeship.key dockercfg dockercfg.encrypted
git add dockercfg.encrypted .gitignore
git commit -m "Adding encrpyted credentials for docker push"
```

* Adapt your Dockerfile

```Dockerfile
FROM codeship/private_base
# ...
```

* Configure your `codeship-services.yml` file. It will probably look similar to the following:

```yaml
app:
  build:
    dockerfile_path: Dockerfile
```

* Configure your `codeship-steps.yml` file. Make sure your `image_name` is identical to the one one on your `codeship-services.yml` and includes the registry as well.

    If you don't want to push the image for each build, add a `tag` entry to the below step and it will only be run on that specific branch or git tag.

```yaml
- service: app
  command: /bin/true
  encrypted_dockercfg_path: dockercfg.encrypted
```

* Commit and push the changes to your remote repository, head over to [Codeship](https://codeship.com/) and watch your build pull the private image from the registry!

As always, feel free to contact [beta@codeship.com](mailto:beta@codeship.com) if you have any questions.

---
title: Jet Installation
layout: page
weight: 75
tags:
  - docker
  - jet
  - introduction
  - installation
  - running locally
categories:
  - docker
---

<div class="info-block">
These commands are only applicable if you want to run the `jet` binary locally. If you only want to run your builds via the Codeship website you can skip these steps.
</div>

* include a table of contents
{:toc}

## Prerequisites

In order to run the _Jet_ binary on your computer you need to have Docker installed and configured. We recommend you follow the guides regarding [Docker Machine](https://docs.docker.com/machine/) to get both the docker binary installed as well as a Docker host configured.

Please note, that, similar to Jet, Docker Machine itself is still in Beta state and things are likely to change.

## Jet

Please follow the steps below for the operating system you are using. See the [Jet Release Notes]({{ site.baseurl }}{% post_url docker/jet/2015-07-16-release-notes %}) for the ChangeLog.

{% for os in site.data.jet.downloads %}
**{{ os.label }}**

{% if os.name == 'windows' %}

Please download the version (`{{ site.data.jet.version }}`) from [our download site](https://dl.bintray.com/codeship/codeship-tool/jet-{{ os.name }}_amd64_{{ site.data.jet.version }}.zip?expiry={{ site.data.jet.expiry }}&id={{ site.data.jet.id }}&signature={{ os.sig_default }}). Once you have done this, you need to extract the archive and copy the binary to your path.

{% else %}

```bash
curl -SLo "jet-{{ site.data.jet.version }}.zip" "https://dl.bintray.com/codeship/codeship-tool/jet-{{ os.name }}_amd64_{{ site.data.jet.version }}.zip?expiry={{ site.data.jet.expiry }}&id={{ site.data.jet.id }}&signature={{ os.sig_default }}"
sudo unzip -ud /usr/local/bin/ "jet-{{ site.data.jet.version }}.zip"
sudo chmod +x /usr/local/bin/jet
```

{% endif %}
{% endfor %}

### Dynamically linked version

The above version is statically linked and will work the same way on all platforms. But it doesn't support certain features, e.g. resolving `.local` DNS names. If your builds require this, please use the dynamically linked version instead.

{% for os in site.data.jet.downloads %}
*  [{{ os.label }}](https://dl.bintray.com/codeship/codeship-tool/jet-{{ os.name }}_amd64_{{ site.data.jet.version }}.zip?expiry={{ site.data.jet.expiry }}&id={{ site.data.jet.id }}&signature={{ os.sig_scratch }})
{% endfor %}


## Making sure Jet works

Once this is done you can check that _Jet_ is working by running `jet help`. This will print output similar to the following.

```
$ jet version
{{ site.data.jet.version }}
$ jet help
Usage:
  jet [command]
...
```

## Docker Configuration

`DOCKER_HOST` must be set. `DOCKER_TLS_VERIFY` and `DOCKER_CERT_PATH` are respected in the same way as with the official Docker client.

If you installed and configured your Docker environment via Docker Machine (and you are on OS X or Linux) and named the environment _dev_, running the following command will set those variables.

```bash
eval $(docker-machine env dev)
```

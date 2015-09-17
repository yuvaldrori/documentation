---
title: Continuous Delivery to Google Cloud Platform with Docker
tags:
  - deployment
  - heroku
  - docker
categories:
  - docker
---

In this article we'll walk you through using the official [Google Cloud SDK docker container](https://hub.docker.com/r/google/cloud-sdk/), set up authentication and interact with resources in the Google Cloud.

We've set up a full example of using the cloud-sdk container in the [codeship-library/google-cloud-deployment](https://github.com/codeship-library/google-cloud-deployment) Github repository.

## Authentication

For authenticating with the Google Cloud Platform we're going to create a *Service account*.

Go to the [GCP console](https://console.developers.google.com), select your project and go to *APIs & auth* &rarr; *Credentials*

![Google Cloud Platform Credentials View](/assets/img/content/google-cloud-deployment/credentials-link.png)

Now click *Add credentials* and add a Service account. Select the JSON download option when asked on the next page. You will download a json file that contains credentials for authentication later. This configuration file and other parameters need to be put into an encrypted environment file that can be used as part of the build.

## Setting up the environment

We're going to create an environment configuration file that sets the following keys:

```
GOOGLE_AUTH_JSON=...
GOOGLE_AUTH_EMAIL=...
```

Store the json file you received from the GCP console into a file named *gcp_deployment.env* in your repository. Make sure to remove all newlines from the file. On Linux and OSX you can use `tr '\n' ' ' < gcp_deployment.env` to get the line and copy it back into the file. Then prepend the single line with `GOOGLE_AUTH_JSON=`. You can find the `GOOGLE_AUTH_EMAIL` on the credentials page in the *Service accounts* section. It has to be from the *Service account* we just created. Make sure to put the file into .gitignore so its never committed with

```bash
echo 'gcp_deployment.env' >> .gitignore
```

Now you can encrypt the env file into a file called `gcp_deployment.env.encrypted`. Take a look at the [encrypted environment files tutorial]({{ site.baseurl }}{% post_url docker/tutorials/2015-09-15-encryption %}) to encrypt the file properly.

Now we're all set with the environment file and can set up our deployment script, Dockerfile, codeship-services.yml and codeship-steps.yml.

# Deployment Script

Before calling any commands against the GCP API we need to authenticate with the gcloud tool. The authentication does not get persisted across steps, so we need to set up a deployment script that authenticates with gcloud and then runs any deployment commands.

The following script will use the encrypted environment variables we set up before to authenticate with the `gcloud` command. Then we're going to start an instance in the Google Compute Engine. Add any commands you need for your specific deployment integration with the Google Cloud Platform. You can also take a look at a [longer example](https://github.com/codeship-library/google-cloud-deployment/blob/master/authenticate_and_run.sh).

Make sure to put it into your repository so we can later on use it inside the Docker container for deployment.

```bash
#!/bin/bash

# exit if any statement returns a non-zero return value
set -e

# Writing environment variables to gcp_config.json and authenticate with gcloud
echo $GOOGLE_AUTH_JSON > gcp_config.json
gcloud auth activate-service-account $GOOGLE_AUTH_EMAIL --key-file ./gcp_config.json --project YOUR_PROJECT_NAME

# Start an instance in Google Compute Engine
gcloud compute instances create testmachine --zone us-central1-a
```

## Dockerfile

The Dockerfile will use the existing `google/cloud-sdk` container and add the deployment script to it.

```bash
# Starting from the existing cloud-sdk container
FROM google/cloud-sdk:latest

# Setting the workdir for all following commands
WORKDIR /app

# Copying our deployment script into the container
COPY scripts/deploy_to_gcp.sh ./
```

## Services

The `codeship-services.yml` file creates the container from the `Dockerfile` we just created and sets the encrypted environment file.

```yaml
googlecloud:
  build: .
  encrypted_env_file: gcp_deployment.env.encrypted
```

## Steps

In the steps we're now calling the deployment script we created before. This will authenticate with GCP and then let you interact with any resources in the Google Cloud.

```yaml
- service: googlecloud
  command: ./deploy_to_gcp.sh
```

Now you have a working integration with the Google Cloud that will automatically update with the latest `google/cloud-sdk` container.

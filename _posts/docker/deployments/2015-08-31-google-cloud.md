---
title: Continuous Delivery to Google Cloud Platform with Docker
weight: 46
tags:
  - deployment
  - heroku
  - docker
categories:
  - docker-integration
---

In this article we'll walk you through using our [Google deployment docker container](https://github.com/codeship-library/google-cloud-deployment), set up authentication and interact with resources in the Google Cloud. The Google Cloud SDK is installed supporting all Google Cloud services, including App Engine (in preview), Google Compute Engine and Google Container Engine.

We've set up a full example of using the cloud-sdk container in the [codeship-library/google-cloud-deployment](https://github.com/codeship-library/google-cloud-deployment) Github repository.

## Authentication

For authenticating with the Google Cloud Platform we're going to create a *Service account*.

Go to the [GCP console](https://console.developers.google.com), select your project and go to *APIs & auth* &rarr; *Credentials*:

![Google Cloud Platform Credentials View]({{ site.baseurl }}/images/docker/credentials-link.png)

Now click *Add credentials* and add a Service account. Select the JSON download option when asked on the next page. You will download a json file that contains credentials for authentication later. This configuration file and other parameters need to be put into an encrypted environment file that can be used as part of the build.

## Setting up the environment

We're going to create an environment configuration file that sets the following keys:

```bash
GOOGLE_AUTH_JSON=...
GOOGLE_AUTH_EMAIL=...
GOOGLE_PROJECT_ID=...
```

Store the json file you received from the GCP console into a file named *google_deployment.env* in your repository. Make sure to remove all newlines from the file. On Linux and OSX you can use `tr '\n' ' ' < google_deployment.env` to get the line and copy it back into the file. Then prepend the single line with `GOOGLE_AUTH_JSON=`. You can find the `GOOGLE_AUTH_EMAIL` on the credentials page in the *Service accounts* section. It has to be from the *Service account* we just created. The `GOOGLE_PROJECT_ID` can be found on the Dashboard of your project in the Google developer console. Make sure to put the file into .gitignore so its never committed with

```bash
echo 'google_deployment.env' >> .gitignore
```

Now you can encrypt the env file into a file called `google_deployment.env.encrypted`. Take a look at the [encrypted environment files tutorial]({{ site.baseurl }}{% post_url docker/tutorials/2015-09-15-encryption %}) to encrypt the file properly.

Now we're all set with the environment file and can set up our deployment script, codeship-services.yml and codeship-steps.yml.

## Deployment Script

Before calling any commands against the GCP API we need to authenticate with the gcloud tool. The authentication does not get persisted across steps, so we need to run the provided authentication command at the beginning of each step that wants to use the gcloud or kubectl tool.

The `codeship/google-cloud-deployment` container provides a deployment command called `codeship_google authenticate`. If you set up the environment variables as described above it will automatically read them and set the configuration up for you. The following example script runs the `codeship_google authenticate` command first and then interacts with the `gcloud` tool to deploy your application. You can use this script as a starting point to write your own deployment script and use it in the later stages.

```bash
#!/bin/bash

# Authenticate with the Google Services
codeship_google authenticate

# Set the default zone to use
gcloud config set compute/zone us-central1-a

# Starting an Instance in Google Compute Engine
gcloud compute instances create testmachine

# Stopping an Instance in Google Compute Engine
gcloud compute instances delete testmachine -q
```

We're first authenticating, then setting the default zone to use and then starting an instance in the Google Compute Engine. Add any commands you need for your specific deployment integration with the Google Cloud Platform. You can also take a look at a [longer example we use for integration testing our container](https://github.com/codeship-library/google-cloud-deployment/blob/master/test/deploy_to_google.sh).

Make sure to put it into your repository so we can later on use it inside the Docker container for deployment.

## Services

The `codeship-services.yml` file uses the `codeship/google-cloud-deployment` container, sets the encrypted environment file and adds the repository folder as a volume at `/deploy` so we can use it as part of the build.

```yaml
googleclouddeployment:
  image: codeship/google-cloud-deployment
  encrypted_env_file: test/google_deployment.env.encrypted
  # Add Docker if you want to interact with the Google Container Engine and Google Container Registry
  add_docker: true
  volumes:
    - ./:/deploy
```

## Steps

In the steps we're now calling the deployment script we created before in `scripts/deploy_to_gcp.sh` in your repository. This will authenticate with GCP and then let you interact with any resources in the Google Cloud.

```yaml
- service: googleclouddeployment
  command: /deploy/scripts/deploy_to_gcp.sh
```

Now you have a working integration with the Google Cloud that will automatically update with the latest `codeship/google-cloud-deployment` container.

## Google Container Engine

Our container also works with the Google Container Engine and Container Registry. The following script will first authenticate with Google, then push a container according to the [Google Container Registry documentation](https://cloud.google.com/container-registry/) and then interact with kubectl to start the service.

```bash
#!/bin/bash

set -e

GOOGLE_CONTAINER_NAME=gcr.io/codeship-production/google-deployment-example
KUBERNETES_APP_NAME=google-deployment
DEFAULT_ZONE=us-central1-a

codeship_google authenticate

echo "Setting default timezone $DEFAULT_ZONE"
gcloud config set compute/zone $DEFAULT_ZONE

echo "Tagging the Docker machine for Google Container Registry push"
docker tag -f codeship/google-deployment-example $GOOGLE_CONTAINER_NAME

echo "Pushing to Google Container Registry: $GOOGLE_CONTAINER_NAME"
gcloud docker push $GOOGLE_CONTAINER_NAME

echo "Starting Cluster on GCE for $KUBERNETES_APP_NAME"
gcloud container clusters create $KUBERNETES_APP_NAME \
    --num-nodes 1 \
    --machine-type g1-small

echo "Deploying image on GCE"
kubectl run $KUBERNETES_APP_NAME --image=$GOOGLE_CONTAINER_NAME --port=8080

echo "Exposing a port on GCE"
kubectl expose rc $KUBERNETES_APP_NAME --create-external-load-balancer=true

echo "Waiting for services to boot"

echo "Listing services on GCE"
kubectl get services $KUBERNETES_APP_NAME

echo "Removing service $KUBERNETES_APP_NAME"
kubectl delete services $KUBERNETES_APP_NAME

echo "Waiting After Remove"

echo "Stopping port forwarding for $KUBERNETES_APP_NAME"
kubectl stop rc $KUBERNETES_APP_NAME

echo "Stopping Container Cluster for $KUBERNETES_APP_NAME"
gcloud container clusters delete $KUBERNETES_APP_NAME -q
```

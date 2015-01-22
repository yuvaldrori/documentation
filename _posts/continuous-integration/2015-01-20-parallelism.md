---
title: Parallelism
weight: 80
tags:
- testing
- continuous integration
- parallelism
categories:
- continuous-integration
---

**Parallelism** allows you to split running your tests across multiple build VMs and speed up your test suite in the process.

* include a table of contents
{:toc}

## Build Pipelines
Each project has multiple **build pipelines**. Each of those pipelines is in effect a build VM running independently of each other. Codeship will first run your setup commands and then any arbitrary _test commands_ you defined for this specific pipeline via the interface. To ease distinguishing different pipelines you can provide a name for each.

![Configuration of build pipelines]({{ site.baseurl }}/images/continuous-integration/parallelization-build-pipelines-configuration.png)

## Deployment Pipeline
If you have a deployment configured for a specific branch and each build pipeline reports success another deployment pipeline will be created to run the actual deployment.

As with the _build pipelines_, Codeship will first run your setup commands and then the deployment steps configured for the branch. The deployment will be displayed as another pipeline. See the screenshot below for the details.

![Configuration of build pipelines]({{ site.baseurl }}/images/continuous-integration/parallelization-deploy-pipelines.png)

### Artefacts Support
As your build and deployment commands are run on multiple virtual machines, **artefacts created during the setup and test steps will not be available during the deployment**. If you need artefacts from the previous steps, make sure to regenerate them during the deployment.

We will introduce a feature which will allow artefacts to persist in the various various pipelines and we will update you as soon as this is available.

## Early Access Phase

### Number of parallel builds
During the early access phase each user has access to 10 build pipelines. Please note, that this number will change according to your subscription once this feature is made generally available.

### Downgrade behaviour
After the early access phase and with the introduction of the final plans the number of build pipelines on your plan might be decreased. Should this be the case we will merge any additional build pipelines into the first one. This is to ensure that all your test commands are run and no tests will be missed.

### UI improvements
The UI and user experience for this feature are not yet finished. We are constantly working on improving parts and we will ship those improvements as soon as they are finished. If you think certain aspects need special focus, please tell us via an email to [support@codeship.com](mailto:support@codeship.com).

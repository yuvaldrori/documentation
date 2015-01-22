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

**Parallelism** allows you to split your test commands across multiple build VMs to speed up your build time.

* include a table of contents
{:toc}

## Test Pipelines
Each project has multiple **test pipelines**. Each of those pipelines is in effect a build VM running independently of each other. Codeship will first run your setup commands and then any arbitrary _test commands_ you defined for this specific pipeline via the interface. To ease distinguishing different pipelines you can provide a name for each one.

![Configuration of test pipelines]({{ site.baseurl }}/images/continuous-integration/parallelization-test-pipelines-configuration.png)

## Deployment Pipeline
If you have a deployment configured for a specific branch and each test pipeline reports a successful run another deployment pipeline will be created to run the actual deployment. You do not need to change anything if you use one of our integrated deployments.

As we do not run your _setup commands_ for the deployment pipeline, please add a script based deployment before the actual deployment and install any required dependencies there.

![Configuration of build pipelines]({{ site.baseurl }}/images/continuous-integration/parallelization-deploy-pipelines.png)

## Early Access Phase

### Artifacts Support
As your build and deployment commands are run on multiple virtual machines, **artifacts created during the test steps will not be available during the deployment**. If you need artifacts from the previous steps, make sure to regenerate them during the deployment.

We will introduce a feature which will allow artifacts to persist in the various pipelines and we will update you as soon as this is available.

### Number of parallel test pipelines
During the early access phase each user has access to 10 test pipelines. Please note, that this number will change according to your subscription once this feature is generally available.

### Downgrade behaviour
After the early access phase and with the introduction of the final plans the number of test pipelines on your plan might be decreased. Should this be the case we will merge any additional test pipelines into the first one. This is to ensure that all your test commands are run and no tests will be missed.

### UI improvements
The UI and user experience for this feature are not yet finished. We are constantly working on improving parts and we will ship those improvements as soon as they are finished. If you think certain aspects need special focus, please tell us via an email to [support@codeship.com](mailto:support@codeship.com).

---
title: ParallelCI
weight: 80
tags:
- testing
- continuous integration
- parallelci
- parallelism
categories:
- continuous-integration
---

**ParallelCI** allows you to split your test commands across multiple build VMs to speed up your build time. See the [ParallelCI feature page](http://codeship.com/features/parallelci) to check out how this helped users improve their build times tremendously.

* include a table of contents
{:toc}

## Test Pipelines
Each project has multiple **test pipelines** that are run in parallel. Each of those pipelines is a build VM running independently of each other. Codeship will first run your setup commands and then any arbitrary _test commands_ you defined for this specific pipeline via the interface. To ease distinguishing different pipelines you can provide a name for each one.

![Configuration of test pipelines]({{ site.baseurl }}/images/continuous-integration/parallelization-test-pipelines-configuration.png)

## Deployment Pipeline
If you have a deployment configured for a specific branch and each test pipeline reports a successful run, your deployment pipeline will be run. You do not need to change anything if you use one of our integrated deployments.

As we do not run your _setup commands_ for the deployment pipeline, please add a script based deployment before the actual deployment and install any required dependencies there.

![Configuration of build pipelines]({{ site.baseurl }}/images/continuous-integration/parallelization-deploy-pipelines.png)

## Artifacts Support
As your build and deployment commands are run on multiple virtual machines, **artifacts created during the test steps will not be available during the deployment**. If you need artifacts from the previous steps, make sure to regenerate them during the deployment using a _script deployment_ added before the actual deployment.

## Downgrade Behavior
If you downgrade to a subscription with fewer parallel pipelines any additional pipelines will merged into the first one. If this is not desirable for your project make sure to manually move the steps to the appropriate test pipelines before downgrading.

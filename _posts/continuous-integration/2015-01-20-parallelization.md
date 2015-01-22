---
title: Parallelization
weight: 80
tags:
- testing
- continuous integration
- parallelization
categories:
- continuous-integration
---
## Build Pipelines

## Deployment Pipeline

## Artifacts Support
Splitting up your test commands to be run on parallel leads to not having all build and deployment commands being executed on the same VM. Build artifacts created during setup and test commands are not persisted to the deployment steps. If you need these artifacts in deployment you would need to regenerate them.
This feature that artifacts persist through the whole pipeline setup, test and deployment will be introduced soon.

## Number of parallel builds during early access phase
During early access there will be 10 parallel builds available. Please note that once we release that feature publicly parallelism will be introduced to our paid plans. This will differ from how many builds there are on the paid plans once the feature is publicly released.

## Downgrade Behaviour
After early access phase and with introducing the final plans you might be downgraded to a smaller amount of parallel builds. If downgraded we will merge the parallel test pipelines that do not fit into the plan in the first test pipeline.
That way we can ensure that always your full test suite will run and not tests will be missed.

## UI Improvements
We are working on the UI and UX to configure parallel builds and make it more usable. This will be released soon.

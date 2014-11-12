---
title: Deploy to AWS CodeDeploy
layout: page
tags:
  - deployment
  - amazon
  - codedeploy
categories:
  - continuous-deployment
---
## Prerequisites

This deployment method is not yet able to create the required configuration on AWS CodeDeploy, neither does it configure the S3 Bucket needed to upload new versions of your application. Please configure those by hand before you deploy for the first time.

## Configuration

Add a new deployment for the branch you want to deploy and choose **AWS CodeDeploy** as the deployment method. You'll then see a form like in the following screenshot.

![AWS CodeDeploy Setup]({{ site.baseurl }}/images/continuous-deployment/aws_codedeploy_setup.png)

Fill out your AWS credentials, the region you want to deploy the application to, as well as the name of your CodeDeploy application, the deployment group and the name (and possible subfolders) of an S3 bucket to use to cache archives of your source code before deploying.

Save the deployment via the green checkmark in the upper right corner and you're good to go.

If you have specific _Deployment Configs_ you can provide one via clicking on _more options_ and providing the name in the appropriate field.

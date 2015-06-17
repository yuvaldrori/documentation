---
title: Deploy to AWS Lambda
layout: page
tags:
  - deployment
  - amazon
  - lambda
categories:
  - continuous-deployment
---



## General
[AWS Lambda](http://aws.amazon.com/lambda/)  is a compute service that runs your code in response to events and automatically manages the compute resources for you, making it easy to build applications that respond quickly to new information.

## Prerequisites

This deployment method does not create the required configuration on AWS Lambda. Please configure this by hand before you deploy for the first time. You can read more about getting setting up your first function on the [AWS Lambda Documentation](http://docs.aws.amazon.com/lambda/latest/dg/welcome.html).

## IAM Policies

It is generally a good idea to create a separate [IAM user](http://docs.aws.amazon.com/general/latest/gr/root-vs-iam.html) for Codeship when deploying to AWS. This allows you to explicitly control which resources Codeship can access during your builds. Please take note of the **Access Key ID** and **Secret Access Key** created during the process, as you'll need this when configuring the deployment.

### Lambda

To deploy into Lambda we need to make sure you’ve given us the correct permissions to deploy into it. Add the following policy to the AWS account which you use for deploying the Lambda function.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "lambda:UpdateFunctionCode",
                "lambda:UpdateFunctionConfiguration",
                "lambda:InvokeFunction",
                "lambda:GetFunction"
            ],
            "Resource": [
                "arn:aws:lambda:YOUR_AWS_REGION:YOUR_AWS_ACCOUNT_ID:function:YOUR_FUNCTION_NAME"
            ]
        }
    ]
}
```

## Environment Variables

You need to add the following environment variables to your project:

* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY
* AWS_DEFAULT_REGION

## Deployment

When you go to the Deploy settings of your repository in your Codeship account you now have to add a Script deployment. In the Script deployment, first put the new code you want to deploy into a zip file and then push it to AWS Lambda.

To test this actually works we’ll get the latest function info and invoke the function after the deployment as well. The same command can also be run from your local machine with the invoke script in the repo you’ve forked. Make sure you have permissions set locally that allow you to invoke a function on AWS Lambda.

Following you can see the list of commands to use and how they’ve been added to a script deployment on Codeship.

```bash
pip install awscli
zip -r LambdaTest.zip LambdaTest.js
aws lambda update-function-code --function-name LambdaTest --zip-file fileb://LambdaTest.zip
aws lambda get-function --function-name “LambdaTest”
aws lambda invoke --function-name LambdaTest --payload "$(cat data.json)" lambda_output.txt
cat lambda_output.txt
```


## Further Reading

+ [AWS Lambda](http://aws.amazon.com/lambda/)
+ [AWS Lambda Documentation](http://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
+ [Integrating AWS Lambda with Codeship](https://blog.codeship.com/integrating-aws-lambda-with-codeship/)

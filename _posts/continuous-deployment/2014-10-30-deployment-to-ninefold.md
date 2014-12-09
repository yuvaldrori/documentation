---
title: Deploy to Ninefold
tags:
  - deployment
  - ninefold
categories:
  - continuous-deployment
---
Deploying to [Ninefold](https://ninefold.com/) from Codeship is as simple as copying and pasting an URL!

# Deploy using the POST hook

Head over to the Ninefold Portal and your existing apps _Overview_ tab. Grab the _Deployment URL_ from there and switch back to Codeship.

To trigger a deployment, add a **Script** deployment to your project and add the following command:

```bash
curl -X POST -d "" YOUR_NINEFOLD_DEPLOYMENT_URL
```

# Deploy using the CLI

Install the CLI on your local machine, sign in to your **ninefold** account and grab the *AuthToken*. Save this token as an environment variable called `AUTH_TOKEN` in your Codeship project.

```bash
gem install ninefold
ninefold signin
ninefold whoami
```

You also need to save the `APP_ID` (a five digit number, prepended by a *#*) you get when listing your applications.

```bash
ninefold app list
```

Once this works, head over to your Codeship project, add a new **script based** deployment and paste the following commands.

```bash
gem install ninefold
ninefold app redeploy --robot --sure
```

See ninefolds [documentation on deploying from a CI service](http://help.ninefold.com/apps/deployment_with_continuous_integration_ci/) for more information.

---
title: Deploy to Google App Engine
weight: 85
layout: page
tags:
  - deployment
  - google app engine
categories:
  - continuous-deployment
---
You can deploy your [Java]({{ site.baseurl }}{% post_url languages/2014-09-03-java-and-jvm-based-languages %}), [Go]({{ site.baseurl }}{% post_url languages/2014-09-03-go %}) or [Python]({{ site.baseurl }}{% post_url languages/2014-09-03-python %}) applications to Google App Engine through Codeship.

The first time you want to connect Codeship to Google App Engine we will
ask for credentials through OAuth.

![Connect got Google App Engine]({{ site.baseurl }}/images/continuous-deployment/connect_to_gae.png)

## Settings

In your App Engine deployment you can set the path that should be used by
the appcfg tool to upload and an optional URL we will call after the deployment
to make sure everything is up and running.

![Google App Engine Settings]({{ site.baseurl }}/images/continuous-deployment/gae_settings.png)

By default we will upload from the root of your repository. If you build for
example your Java app in a different directory you have to set the path to the
that different directory. We will call the appcfg deployment tool with that path
to deploy your application from this build output.

In our [Java App Engine Example](https://github.com/CodeshipExamples/java-app-engine)
we compile the application with `gradle` and the result will be written to
build/exploded-war. We set `build/exploded-war` as the path, so the code will
be taken from there.

# appcfg.py or appcfg.sh

By default we search for an `app.yaml` file in the path you've set. If we
find it we will use the `appcfg.py` script to upload your application. Otherwise we
expect it to be a Java application and use `appcfg.sh`.

# App Engine Authentication Issues

The specific implementation Google App Engines uses to authenticate with other
services like Codeship omits certain information if you re-authenticate.
(Specifically the OAuth [refresh token](https://auth0.com/docs/refresh-token).)

If you encounter authentication problems with your GAE deployments,
please head over to the [Google OAuth Application Settings](https://security.google.com/settings/security/permissions)
page and remove the Codeship application from your account.
Once you've done the above step, disconnecting and reconnecting to App Engine
on [Connected Services](https://codeship.com/authentications) will update your authentication settings
and allow deployments to App Engine.

Please save the deployment settings after updating the reconnting to GAE to ensure that we use the newly created token.

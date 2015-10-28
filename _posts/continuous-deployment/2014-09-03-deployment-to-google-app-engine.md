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

# Refresh Token Issues

Google only includes the refresh_token the first time a user connects to Google,
after that disconnecting and reconnecting GAE authentication on
[Connected Services](https://codeship.com/authentications) will not include the token.
If you encounter problems with your GAE deployment please head over to
[Google OAuth Application Settings](https://security.google.com/settings/security/permissions)
and remove the Codeship application from the account.
Reconnecting after you removed the Codeship application will tell Google to
send the refresh token to Codeship.

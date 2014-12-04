---
title: Deploy to Divshot
tags:
- deployment
- divshot
categories:
- continuous-deployment
---

[Divshot](https://divshot.com) is a hosting tool for static websites. To deploy from Codeship to Divshot follow the steps below.

First you need to setup your application locally. To do so please follow the [Getting Started](http://docs.divshot.com/guides/getting-started) guide. Don't forget to commit the `divshot.json` file to your repository.

Once you can deploy your site successfully from your local machine you need to setup your Divshot user token on the Codeship project. Grab the login token from `~/.divshot/config/user.json` and save it as an environment variable called `DIVSHOT_TOKEN`.

Then add a new **script based deployment** to your project and include the following commands

```shell
npm install -g divshot-cli
divshot push development --token "${DIVSHOT_TOKEN}"
```

Don't forget to specify the actual Divshot environment you want to deploy to (_development_ in the example above).

For more information check out the fantastic documentation made available by the Divshot team at [docs.divshot.com](http://docs.divshot.com).

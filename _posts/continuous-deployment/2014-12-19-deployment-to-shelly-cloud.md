---
title: Deploy to Shelly Cloud
weight: 90
layout: page
tags:
  - deployment
  - shelly cloud
categories:
  - continuous-deployment
---
## User
To integrate [Shelly Cloud](https://shellycloud.com) with Codeship, you first
have to create a special user who will perform deployments. You can do it using
[shelly gem](https://shellycloud.com/documentation/members#add).

### SSH Public Key authentication
Shelly Cloud allows to perform a `git push` only if uploaded
SSH Public Key matches the SSH Private Key on the local machine.
To upload public key to Shelly Cloud, you have to copy Codeship SSH Public
Key from the `General` section of your project, save it to the
temporary file and login as a deployment user using that key:

```bash
$ shelly login codeship@example.com --key=~/.ssh/id_rsa_from_codeship.pub
```

Please notice that SSH Public Key will be removed from Shelly Cloud after
running `shelly logout`. You should login to your main account **without**
logging out.

## Deployment method
You can easily set up deployment on Shelly Cloud by choosing **Custom Script**
as deployment method with the following content:

```bash
git push SHELLY_REMOTE "${COMMIT_ID}:refs/heads/master"
```

Use your cloud repository url in the place of `SHELLY_REMOTE`. You
can use `shelly info` to check it.

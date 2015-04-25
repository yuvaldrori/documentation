---
title: Push to Remote Repository
layout: page
tags:
  - deployment
  - git
  - push
categories:
  - continuous-deployment
---
In order to push to a remote repository you need to follow these steps:

- Remove the deploy key from the repository 
- Add it to a [special user]((https://developer.github.com/guides/managing-deploy-keys/#machine-users)) and add this user to the repository.
- Fetch the complete repository including any missing remote branches with the following script: 

```shell
#!/bin/sh
git fetch --unshallow || true
git fetch origin "+refs/heads/*:refs/remotes/origin/*"
# checkout a remote branch with
# git checkout -b test origin/test
```

(This is required as Codeship only downloads the last 50 commits for the specific branch that triggered the build)

- Make sure the remote is a SSH based URL and not HTTPS .
- Commit your changes (probably including `--skip-ci` in the commit summary so you don't trigger another build)
- Push to your remote repository.

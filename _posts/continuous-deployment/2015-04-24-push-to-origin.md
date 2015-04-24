---
title: Push to Origin
weight: 85
layout: page
tags:
  - deployment
  - origin
  - push
categories:
  - continuous-deployment
---
In order to push you'd need to follow these steps:

- Remove the deploy key from the repository 
- Add it to a special user and add this user to the repository. [Example.](https://developer.github.com/guides/managing-deploy-keys/#machine-users)
- Fetch the complete repository including any missing remote branches with the following script: 

```shell
#!/bin/sh
git fetch --unshallow || true
git fetch origin "+refs/heads/*:refs/remotes/origin/*"
# checkout a remote branch with
# git checkout -b test origin/test
```

(We only clone a subset of the repository to speed up build times)

- Make sure the remote is a SSH based URL and not HTTPS 
- Commit your changes (probably including --skip-ci in the commit message so you don't trigger another build)
- Push to your remote repository.

---
title: My builds are not triggered anymore
layout: page
tags:
  - faq
  - build error
  - github
  - bitbucket
categories:
  - faq
---
In general a build is triggered on Codeship on each push to your remote repository. Hence there needs to be a hook set up at your repository provider (GitHub, Bitbucket).

## Hook URL

You can find your project UUID in the project settings on the ***General*** page.

### GitHub

```
https://lighthouse.codeship.io/github/YOUR_PROJECT_UUID
```

### BitBucket

```
https://lighthouse.codeship.io/bitbucket/YOUR_PROJECT_UUID
```

## Issues with the hook in your repository

* Please check if the Codeship hook is configured and active for your repository on GitHub / Bitbucket.
* Check if the project UUID is the same as on Codeship. You will find your project UUID on Codeship in your project settings on the ***General*** page.

## Issues with BitBucket

There is a bug with BitBucket web hooks, which won't supply needed information for pushes which don't include new commits. (E.g. pushing a merge of two branches). The full bug report on this is available at the [BitBucket issue tracker](https://bitbucket.org/site/master/issue/7775/post-service-does-not-provide-useful).

As a workaround we recommend merging branches and explicitly creating a merger commit. On the command line you would include the `--no-ff` flag to achieve this. Please note, that even this workaround won't completely resolve the issue. See the above mentioned report for the full details.

## Issues with Codeship

It also might be possible that there are issues on Codeship. Please check our [Codeship Status Page](http://codeshipstatus.com){:target="_blank"} for further information.

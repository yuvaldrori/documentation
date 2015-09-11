---
title: "Tutorial: Custom Notifications"
layout: page
weight: 45
tags:
  - docker
  - tutorial
  - push
  - registry
categories:
  - docker
---

* include a table of contents
{:toc}

## Notifications

Codeship allows you to configure a number of standard notifications for your build via your project settings. For details on what notification methods are supported, as well as how to configure notifications for your builds, check out the [documentation]({{ site.baseurl }}{% post_url administration/2014-09-02-notifications %}#encryption-commands). 

## Custom Notifications

You can also define custom steps in your build pipeline to push notifications via methods not supported by Codeship. This tutorial will cover using a simple slack script as a custom notification method.

### The notification script

First of all, we can create a simple notification script, pulling all configuration and credentials from environment variables, or mounted volumes should we need to use build artifacts.

Lets start with a simple, project agnostic slack script.

```bash
#!/usr/bin/env bash
#/ Usage: script/slack -c <channel>
#/ Send standard input to Slack.
set -e

: ${SLACK_WEBHOOK_PATH:="unknown"}
: ${SLACK_WEBHOOK_URL:="https://hooks.slack.com/services/$SLACK_WEBHOOK_PATH"}
: ${SLACK_USERNAME:="deploybot"}


# parse the arguments
channel=
while [ $# -gt 0 ]; do
    case "$1" in
        -c)
            channel="$2"
            shift
            shift ;;
    esac
done

text=
if test "${BASH_VERSION%%[^0-9]*}" -ge 4;
then
    read -t 0 || {
        echo "standard input empty" >&2
        usage
    }
fi
text="$(cat)"

# build the message payload
payload="payload={
\"channel\": \"#$channel\",
\"username\": \"${SLACK_USERNAME}\",
\"text\": \"$text\"
}
"

# send API request to slack
curl -s -X POST --data-urlencode "$payload" "$SLACK_WEBHOOK_URL"
```

Next we can create a simple script for our project with some more specifics for our use case.

```bash
#!/bin/bash
#/ Usage: script/slack-deploy
#/ Send a deploy notification to #dev on Slack.
set -e

CI_BRANCH=${CI_BRANCH:-no-branch}
CI_COMMITTER_USERNAME=${CI_COMMITTER_USERNAME:-no-username}
CI_COMMIT_ID=${CI_COMMIT_ID:-no-commit-id}

commit_url="https://github.com/myuser/myproject/commit/$CI_COMMIT_ID"
short_sha="$(echo "$CI_COMMIT_ID" | cut -c1-7)"

message="myproject/%s deployed to production at <%s|%s> by @%s. "

printf "$message\n" \
    "$CI_BRANCH" \
    "$commit_url" \
    "$short_sha" \
    "$CI_COMMITTER_USERNAME" |
./slack -c development
```

### Integrating the notification script

It's quite simple to integrate a simple script like this into the deployment pipeline. First we can build it into a standalone container, or use an existing one from elsewhere in the pipeline which has the deploy script added to it.

```
# Dockerfile.notify
FROM ubuntu

RUN apt-get install -y curl

ADD ./script/ ./
```

We'll need to provide this container with the necessary environment variables. The standard `CI_` variables will be provided automatically, however we'll need to provide the `SLACK_WEBHOOK_PATH`. This can be safely injected via the `encrypted_env_file` service declaration, and the [encryption commands]({{ site.baseurl }}{% post_url docker/jet/2015-05-25-cli %}#encryption-commands). By encrypting this environment variable, and adding it to our repository, it can be later decoded and provided to our notifications container.

```yaml
deploynotify
  build:
    image: myuser/myrepo-deploynotify
    dockerfile_path: Dockerfile.notify
  encrypted_env_file: deploy.env.encrypted
```

By adding a relevant step to the steps file, we can control under what conditions this notification fires.

```yaml
- service: deploynotify
  command: ./slack-deploy
  tag: master
```

Since you can integrate any container you wish into your pipeline, there are no limitations on what notifications you can use. As always, feel free to contact [beta@codeship.com](mailto:beta@codeship.com) if you have any questions.
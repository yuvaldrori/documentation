---
title: No such file or directory config/your_config.yml
layout: page
tags:
  - faq
  - build error
categories:
  - faq
---
If it's a configuration file which you ignored in your repository, create a `your_config.yml.example` with data that works for your tests an add it to your repository. Then add the following command to your **setup commands** so the YAML file is properly set up.

```shell
# project settings > test settings > setup commands
cp your_config.yml.example your_config.yml
```

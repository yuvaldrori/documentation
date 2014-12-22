---
title: How to enable access for Codeship on your Firewall
layout: page
tags:
  - faq
  - firewall
  - security group
  - ip addresses
  - iam
categories:
  - faq
---
## IP Addresses

Codeship is Hosted in the US-East region of EC2. You can find all the IP Addresses allocated to EC2 in their [Developer Forum](https://forums.aws.amazon.com/ann.jspa?annID=1701).

You can enable access for those ranges on your own servers firewall settings.

## AWS Security Group and account ID

* Security group: *sg-64c2870c*
* Account ID: *841076584876*

To add it as a source to your EC2 Security group set the Source to Custom-IP and add the following snippet as the source.

```shell
841076584876/sg-64c2870c
```

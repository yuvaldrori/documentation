#!/bin/bash
set -e

echo -e "\e[36mBuilding with base URL /${CI_BRANCH}\e[39m"
sed -i'' -e "s|^baseurl:.*|baseurl: /${CI_BRANCH}|" _config.yml
bundle exec jekyll build --destination "/site/${CI_BRANCH}"

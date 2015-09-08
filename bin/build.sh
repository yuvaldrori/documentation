#!/bin/bash
set -e

destination="/site/${CI_BRANCH}"

echo -e "\e[36mBuilding with base URL /${CI_BRANCH}\e[39m"
sed -i'' -e "s|^baseurl:.*|baseurl: /${CI_BRANCH}|" _config.yml
mkdir -p "${destination}"
bundle exec jekyll build --destination "${destination}"

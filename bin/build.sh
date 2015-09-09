#!/bin/bash
set -e

log() {
	echo -e "\e[36m$@\e[39m"
}

# Special treatment for the "master" branch to deploy to /documentation instead
# of /master
target="${CI_BRANCH}"
if [ "${CI_BRANCH}" == "master" ]; then
	target="documentation"
fi

# Where do we want to generate the site at?
mkdir -p "${destination:=/site/$target}"

# Compile the site
log "Building with base URL /${target}"
sed -i'' -e "s|^baseurl:.*|baseurl: /${target}|" _config.yml
bundle exec jekyll build --destination "${destination}"

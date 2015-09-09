#!/bin/bash
set -e

log() {
	echo -e "\e[36m$@\e[39m"
}

check_and_move() {
	local file=${1:?'You need to pass a file!'} && shift
	local destination=${1:?'You need to pass a destination!'} && shift
	local tmp="/site/.jet"
	if [ -f "${tmp}/${file}" ]; then
		mv "${tmp}/${file}" ${destination}
	fi
}

# Special treatment for the "master" branch to deploy to /documentation instead
# of /master
target="${CI_BRANCH}"
if [ "${CI_BRANCH}" == "master" ]; then
	target="documentation"
fi

# Where do we want to generate the site at?
mkdir -p "${destination:=/site/$target}"

# Move files from the Jet deploy process into their correct locations
# they are saved to the volume by a previous step and only generated for
# branches with the required input data
check_and_move "_jet.yml" "_data/"
check_and_move "2015-07-16-release-notes.md" "_posts/docker/jet"

# Compile the site
log "Building with base URL /${target}"
sed -i'' -e "s|^baseurl:.*|baseurl: /${target}|" _config.yml
bundle exec jekyll build --destination "${destination}"

#!/bin/sh
set -e
log() { echo -e "\e[36m$@\e[39m"; }

# Special treatment for the "master" branch to deploy to /documentation instead
# of /master
target="${CI_BRANCH}"
if [ "${CI_BRANCH}" = "master" ]; then
	target="documentation"
fi

# Where do we want to generate the site at?
destination="/site/$target"
if [ "${destination}" != "/site/" ]; then
	rm -rf "${destination}" && mkdir -p "${destination}"
fi

# set the base URL
sed -i'' -e "s|^baseurl:.*|baseurl: /${target}|" _config.yml

# Jet release notes and current version
jet_source="/site/.jet"
if [ -f "_data/jet.yml" ]; then
	sed -i'' -e "s|^version:.*|version: $(cat ${jet_source}/version)|" "_data/jet.yml"
fi
if [ -f "_posts/docker/jet/2015-07-16-release-notes.md" ]; then
	cat "${jet_source}/release-notes" >> "_posts/docker/jet/2015-07-16-release-notes.md"
fi
rm -rf "${jet_source}"

# cleanup
log "Cleanup"
rm -rf \
	.dockerignore \
	.scss-lint.yml \
	CONTRIBUTING.md \
	Gemfile \
	Gemfile.lock \
	_lifecycle.json \
	_robots.txt \
	_website.json \
	gulpfile.js \
	node_modules \
	npm-shrinkwrap.json \
	package.json

tries=10
set +e
for (( i = 1; i <=${tries}; i++ )); do
	log "Trying (${i} of ${tries}) to build the site with base URL /${target}"
	bundle exec jekyll build --destination "${destination}"
	status=$?

	if [ ${status} -eq 0 ]; then break; fi
done
exit ${status}

#!/bin/bash
set -e
log() { echo -e "\e[36m$@\e[39m"; }

# configuration
unset $latest_version
target="/site/.jet"

log "Preparing Jet release notes and current version"
rm -rf "${target}" && mkdir -p "${target}/sync"
aws s3 sync "s3://${JET_RELEASE_BUCKET}/" "${target}/sync" --exclude=* --include=*.changelog --quiet

# write the release notes
find "${target}/sync/" -type f -not -size 0 | natsort -r | \
while read line; do
	version=$(basename ${line} | sed -e 's/\.changelog//')
	if [ -z "${latest_version}" ]; then
		# set the latest version on the first iteration of the while loop
		echo "${latest_version:=$version}" > "${target}/version"
	fi
	cat >> "${target}/release-notes" <<-EOF

		## ${version}

		$(cat ${line})
	EOF
done

# cleanup
rm -rf "${target}/sync"

# print the latest version
echo "latest jet version is ${latest_version}"

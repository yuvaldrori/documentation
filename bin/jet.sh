#!/bin/sh
set -e

log() {
	echo -e "\e[36m$@\e[39m"
}

# configuration and error handline
changelog="_posts/docker/jet/2015-07-16-release-notes.md"
metadata="_data/jet.yml"
if [ ! -f ${changelog} -o ! -f ${metadata} ]; then
	log "The release notes or metadata file doesn't exist on that branch, exiting!"
	exit 0
fi

log "Generating the Jet release notes"

# sync the release bucket to a local volume
rm -rf "${target:=/site/.jet/}" && mkdir -p "${target}"
aws s3 sync "s3://${JET_RELEASE_BUCKET}/" "${target}" --exclude=* --include=*.changelog

# write the release notes
find "${target}" -type f -not -size 0 | natsort -r | \
while read line; do
	version=$(basename ${line} | sed -e 's/\.changelog//')
	cat >> ${changelog} <<-EOF

		## ${version}

		$(cat ${line})
	EOF
done

# update the metadata
path=$(find ${target} -type f -not -size 0 | natsort -r | head -n 1)
version=$(basename ${path} | sed -e 's/\.changelog//')
sed -i'' -e "s|^version:.*|version: ${version}|" ${metadata}

# cleanup
rm -rf "${target}" && mkdir "${target}"
mv "${changelog}" "${metadata}" "${target}"

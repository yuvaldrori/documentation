#!/bin/sh
set -e
action=${1:?'You need to pass an action!'} && shift

log() {
	echo -e "\e[36m$1\e[39m"
}

case "$action" in
	'sync')
		log "Pushing documenation to s3://${AWS_S3_BUCKET}/${CI_BRANCH}/"
		aws s3 sync "/site/${CI_BRANCH}/" "s3://${AWS_S3_BUCKET}/${CI_BRANCH}/" --acl public-read --follow-symlinks --delete
		;;
	'configure_website')
		log "Pushing website configuration"
		config_file=${1:?'You need to pass an action!'} && shift
		aws s3api put-bucket-website --bucket "${AWS_S3_BUCKET}" --website-configuration "file://${config_file}"
		;;
		'configure_lifecycle')
			log "Pushing lifecycle configuration"
			config_file=${1:?'You need to pass an action!'} && shift
			aws s3api put-bucket-lifecycle --bucket "${AWS_S3_BUCKET}" --lifecycle-configuration "file://${config_file}"
			;;
		'robots')
			log "Pushing robots.txt file"
			aws s3 cp _robots.txt "s3://${AWS_S3_BUCKET}/robots.txt" --acl public-read
			;;
	*)
		log "Invalid action ${action} :("
		exit 1
		;;
esac

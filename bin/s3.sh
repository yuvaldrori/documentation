#!/bin/sh
set -e
action=${1:?'You need to pass an action!'} && shift

case "$action" in
	'sync')
		echo -e "\e[36mPushing documenation to s3://${AWS_S3_BUCKET}/${CI_BRANCH}/\e[39m"
		aws s3 sync "/site/${CI_BRANCH}/" "s3://${AWS_S3_BUCKET}/${CI_BRANCH}/" --acl public-read --follow-symlinks --delete
		;;
	'configure_bucket')
		echo -e "\e[36mPushing bucket configuration\e[39m"
		config_file=${1:?'You need to pass an action!'} && shift
		aws s3api put-bucket-website --bucket "${AWS_S3_BUCKET}" --website-configuration "file://${config_file}"
		;;
	*)
		echo -e "\e[36mInvalid action ${action} :(\e[39m"
		exit 1
		;;
esac

#!/bin/sh
# the config file is relative to the repository root
CONFIG_FILE="_s3.json"
aws s3api put-bucket-website --debug --bucket "${S3_BUCKET}" --website-configuration "file://${CONFIG_FILE}"

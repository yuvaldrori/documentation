#!/bin/sh
# This script requires that you exported your API token to the
# CODESHIP_API_TOKEN environment variable before you can use it.
# (and it requires a working python installation for formatting the JSON
# responses)
set -e

echo "\n#\n# Projects Overview\n#"
curl -s "https://codeship.com/api/v1/projects.json?api_key=${CODESHIP_API_TOKEN}" | python -mjson.tool

echo "\n#\n# Single Project (Documentation)\n#"
curl -s "https://codeship.com/api/v1/projects/33837.json?api_key=${CODESHIP_API_TOKEN}" | python -mjson.tool

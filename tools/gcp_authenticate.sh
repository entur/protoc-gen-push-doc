#!/bin/bash

# Authenticate with google cloud. Requires GCLOUD_SERVICE_KEY

set -euo pipefail

echo "${GCLOUD_SERVICE_KEY}" > "${HOME}/account-auth.json"
gcloud auth activate-service-account --key-file "${HOME}/account-auth.json"
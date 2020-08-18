#!/bin/bash

set -euo pipefail

VER="218.0.0-linux-x86_64"
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${VER}.tar.gz
tar -xvzf google-cloud-sdk-${VER}.tar.gz
./google-cloud-sdk/install.sh -q
./google-cloud-sdk/bin/gcloud components update
./google-cloud-sdk/bin/gcloud -q components install pubsub-emulator
rm google-cloud-sdk-${VER}.tar.gz

PATH="$(pwd)/google-cloud-sdk/bin:${PATH}"
export PATH="${PATH}"
echo "Path is now: ${PATH}"

ln -s "$(pwd)/google-cloud-sdk/bin/gcloud" "/usr/bin/gcloud"
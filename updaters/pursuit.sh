#! /usr/bin/env bash

set -ex

# This script installs or updates the Pursuit server. It does not attempt to
# take care of data migrations; where they are needed, they must be done
# manually.

# todo: have this script called by a wrapper which starts by ensuring we have
# the latest config from the purescript/infrastructure repo?

if [ $(id --user) -ne 0 ]
then
  echo >&2 "This script must be run as root"
  exit 1
fi

# Hardcoded for now
pursuit_version="v0.7.3"

download_url="https://github.com/purescript/pursuit/releases/download/${pursuit_version}/pursuit.tar.gz"

echo "[$(date)] $0: starting pursuit install"
tmpdir="$(mktemp -d)"
pushd "$tmpdir"
wget "$download_url"

mkdir -p /var/www/pursuit

tar xzf pursuit.tar.gz -C /var/www/pursuit

systemctl restart pursuit.service

echo "[$(date)] $0: done pursuit install"

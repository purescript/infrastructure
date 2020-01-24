#! /usr/bin/env bash

set -ex

# This script is intended to be run on a basic Ubuntu 18.04 server in order to
# set things up to enable deploying PureScript apps (e.g. Pursuit, Try
# PureScript) to it.

# Before running this script, you should clone the repo at the path
#
#    /var/www/purescript-infrastructure
#

if [ $(id --user) -ne 0 ]
then
  echo >&2 "This script must be run as root"
  exit 1
fi

pushd /

# Install apt packages

# certbot (for Let's Encrypt SSL certs)
add-apt-repository -y universe
add-apt-repository -y ppa:certbot/certbot

apt-get update
apt-get install -y \
  software-properties-common nginx zlib1g libgmp10 certbot

# Create 'deploy' user
if ! getent passwd deploy
then
  useradd --create-home --user-group --shell /bin/bash deploy
fi

# Remove default nginx configuration
rm /etc/nginx/sites-enabled/default

# 

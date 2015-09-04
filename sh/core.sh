#!/bin/bash
set -e

apt-get update
# Install build tools
apt-get install -y \
  build-essential \
  curl \
  git \
  libav-tools \
  libcairo2-dev \
  nfs-common \
  portmap \
  python-software-properties \
  ruby \
  vim 

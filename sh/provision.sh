#!/usr/bin/env bash

# Exit if any command returns non zero
set -e

if [ -e "/etc/vagrant-provisioned" ];
then
    echo "Vagrant provisioning already completed. Skipping..."
    exit 0
else
    echo "Starting Vagrant provisioning process..."
fi

# Change the hostname so we can easily identify what environment we're on:
echo "vagrant-grommet" > /etc/hostname
# Update /etc/hosts to match new hostname to avoid "Unable to resolve hostname" issue:
echo "127.0.0.1 vagrant-grommet" >> /etc/hosts
# Use hostname command so that the new hostname takes effect immediately without a restart:
hostname vagrant-grommet


# Install core components
/vagrant/sh/core.sh

# Install Node.js
/vagrant/sh/nodejs.sh

# Install scss_lint
/vagrant/sh/scss_lint.sh

# Fix some environment things to make node happier
/vagrant/sh/env_fixes.sh

# cleanup apt
/vagrant/sh/cleanup_apt.sh

#Done provisioning
touch /etc/vagrant-provisioned

echo "--------------------------------------------------"
echo "Your vagrant instance is running at: 192.168.33.11"

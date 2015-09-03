#!/bin/bash
# Install node.js v0.12
curl -sL https://deb.nodesource.com/setup_0.12 | bash -
# Above command runs apt-get update

apt-get install -y \
  nodejs

# make some npmrc defaults
cp -r /vagrant/sh/.npmrc /home/vagrant/
chown vagrant:vagrant /home/vagrant/.npmrc

# Add required node related items to your environment
PROFILE=/home/vagrant/.profile
echo '# Setup node paths' >> $PROFILE
echo 'export NODE_ROOT=$HOME/.npm-packages' >> $PROFILE
echo 'export NODE_PATH=$NODE_ROOT/lib/node_modules' >> $PROFILE
echo 'export PATH=$NODE_ROOT/bin:$PATH' >> $PROFILE

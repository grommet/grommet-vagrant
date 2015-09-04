# vagrant-grommet
A vagrant box to make developing with grommet easier. Built on 64bit ubuntu trusty.


# Proxy Setup
If you are behind a proxy you will want to have your environment variables set appropriately.
In order to build and download boxes with vagrant you will need `http_proxy` and `https_proxy` set appropriately for your environment.

After that install [vagrant-proxy](http://tmatilai.github.io/vagrant-proxyconf/). This tool updates your vagrant box with the appropriate proxy information for various tools (including git and npm). If you've already provisioned a box, you'll have to reprovision `vagrant provision` to get the vagrant-proxy to be good again.

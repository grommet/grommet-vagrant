# vagrant-grommet
A vagrant box to make developing with grommet easier. Built on 64bit ubuntu trusty.


# Proxy Setup
If you are behind a proxy you will want to have your environment variables set appropriately.
In order to build and download boxes with vagrant you will need `http_proxy` and `https_proxy` set appropriately for your environment.

After that install [vagrant-proxy](http://tmatilai.github.io/vagrant-proxyconf/). This tool updates your vagrant box with the appropriate proxy information for various tools (including git and npm). If you've already provisioned a box, you'll have to reprovision `vagrant provision` to get the vagrant-proxy to be good again.

# Windows users
If you are on windows you will likely have to deal with long path issues with your node_modules dependencies. 
As of 2015-09-04 there are no great solutions. 

## On the edge
If you are just over the edge of the 256 character limit, you can mount a different path and have your source code at a lower starting number of characters (say C:/dev/).

Simply add something like the below to your Vagrantfile
```
 config.vm.synced_folder "C:/dev", "/vagrant_data"
```

## Using npm version 3
Most promising long-term solution is running `npm@3.x` since it flattens the node_modules hierarchy. However there are still blocking issues dealing with call stack issues. 
You can install it with `npm install -g npm@3.x-latest` then run `hash -d npm` to reset bash's cached path to npm (you could also just logout and back in).


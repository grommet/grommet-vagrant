# vagrant-grommet
A Vagrant box to make developing with grommet easier. Built on 64bit ubuntu trusty.

# Getting Started
Install [Vagrant](https://www.vagrantup.com/)
and [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

Clone this repository and run the following to start and build the box.
```
cd vagrant-grommet
vagrant up
vagrant ssh
```
To see ssh configuration to login from another terminal simply run `vagrant ssh-config`.

# Proxy Setup
If you are behind a proxy you will want to have your environment variables set appropriately.
In order to build and download boxes with vagrant you will need `http_proxy` and `https_proxy` set appropriately for your environment.

After that install [vagrant-proxy](http://tmatilai.github.io/vagrant-proxyconf/). This tool updates your vagrant box with the appropriate proxy information for various tools (including git and npm). If you've already provisioned a box, you'll have to reprovision `vagrant provision` to get the vagrant-proxy to be good again.

# Forwarded ports
By default ports 8002, 8080, and 9000 are forwarded. That means you can hit localhost:${port} from your host and go to the VM.
Adding a port is as easy as adding this line to your Vagrantfile. 
```
config.vm.network "forwarded_port", guest: 9999, host: 9999, auto_correct: true
```
For changes to take effect you will have to restart the VM at minimum, or run `vagrant reload --no-provision` which will shutdown the vm, restart it, and apply the network settings again. 

If you don't want to restart you can add the port forwarding in the settings, network, port forwarding section of the VM config in VirtualBox.

Note that if there is a port collision that Vagrant will automatically pick a different port for you, so you might goto localhost:2201 instead of 3000 to hit port 3000 on your VM.

If when running gulp you cannot connect via your host check that gulp is running on all host devices.

```
netstat -an | grep ${port}
```
If you don't see  `0.0.0.0:${port}` then you will need to add
```
  devServerHost: '0.0.0.0',
```
to your gulpfile and rerun gulp dev.

# Windows users
If you are on windows you will likely have to deal with long path issues with your node_modules dependencies. This is because you are running off of the windows file system and merely mounting it in the linux VM.

The error looks something like this where example is the name of the project/directory.
```
npm ERR! path /host/test/example/node_modules/gulp-rsync/node_modules/lodash.every/node_modules/lodash.forown/node_modules/lodash._basecreatecallback/node_modules/lodash.bind/node_modules/lodash._createwrapper/node_modules/lodash.isfunction/package.json.fbd4e42661f43af1c9f92cbf58aa0816
npm ERR! code EPERM
npm ERR! errno -1

npm ERR! Error: EPERM, open '/host/test/example/node_modules/gulp-rsync/node_modules/lodash.every/node_modules/lodash.forown/node_modules/lodash._basecreatecallback/node_modules/lodash.bind/node_modules/lodash._createwrapper/node_modules/lodash.isfunction/package.json.fbd4e42661f43af1c9f92cbf58aa0816'
npm ERR!     at Error (native)
npm ERR!  { [Error: EPERM, open '/host/test/example/node_modules/gulp-rsync/node_modules/lodash.every/node_modules/lodash.forown/node_modules/lodash._basecreatecallback/node_modules/lodash.bind/node_modules/lodash._createwrapper/node_modules/lodash.isfunction/package.json.fbd4e42661f43af1c9f92cbf58aa0816']
npm ERR!   errno: -1,
npm ERR!   code: 'EPERM',
npm ERR!   path: '/host/test/example/node_modules/gulp-rsync/node_modules/lodash.every/node_modules/lodash.forown/node_modules/lodash._basecreatecallback/node_modules/lodash.bind/node_modules/lodash._createwrapper/node_modules/lodash.isfunction/package.json.fbd4e42661f43af1c9f92cbf58aa0816' }
```

As of 2015-09-04 there are no great solutions. 

## Windows: On the max-path length edge
If you are just over the edge of the 256 character limit, you can mount a different path and have your source code at a lower starting number of characters (say C:/dev/).

Simply add something like the below to your Vagrantfile
```
 config.vm.synced_folder "C:/dev", "/vagrant_data"
```

## Windows: On the max-path length edge 2
You can also shorten the path by installing the same version. In the above gulp-rsync has a deeply nested path, if you are close you can add lodash.every to your dependency list with the same version string as in gulp-rsync's package.json. You will need to install the package `npm install -g <package>`  to look at the package.json. You should use the same version as in your package.json. If you are doing this you probably want to use a static version string.

## Using npm version 3
This is the most promising long-term solution is running `npm@3.x` since it flattens the node_modules hierarchy. However there are still blocking issues in `npm@3.x` preventing it from being `npm@latest`. 
You can install it with `npm install -g npm@3.x-latest` then run `hash -d npm` to reset bash's cached path to npm (you could also just logout and back in).


# Open issues

## Polling uses too many CPU cycles
The webpack/watchpack plugin poll node_modules unnecessarily causing lots of CPU cycles. 

What does this mean? It means if you are editing your source files from the host machine that you won't see webpack automatically rebuild the UI.

To see this you had to add 
```
watchOptions: {
  poll: true
}
```
to your `gulpfile.js` in your project.

### workarounds for polling
* Don't turn polling on and simply touch a file from the VM in a watched directory when you want to force a rebuild.
* Don't turn polling on and use rsync from host to client to sync files and force timestamp updates. You will want to run in a non-shared directory.
* Leave polling on and deal with the High VM CPU usage

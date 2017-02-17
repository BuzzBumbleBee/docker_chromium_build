# Overview
------------ 
Docker container for building chromium from shource
 

# Features
------------ 
 
* Based on Ubuntu 16.04
* Downloads depot tool on build 
* Intended to be used with a shared volume with host 
* sudo enabled (password: build) 
 
# Usage
------------ 

*The below assumes you are working from your home directory*

1. Clone the repo
```
git@github.com:BuzzBumbleBee/docker_chromium_build.git
```
2. Navigate to the repo you just cloned
```
cd docker_chromium_build
``` 
3. Build the docker image (can take some time) [Note: you may need to use "sudo" in order to use Docker]
```
docker build -t chromium:build ./
``` 
4. Make your chromium src folder on host outside of the cloned repo folder (this way source and out directory is available within container and on host)
```
mkdir ../chromium
```
5. Start docker container (named build with above chromium dir mounted to "/home/$USER/build/chromium") 
```
docker run -it -h chromium --name chromium-build -v /home/$USER/chromium:/home/build/chromium chromium:build /bin/bash
```
6. change into the chromium directory and run normal fetch / sync / build

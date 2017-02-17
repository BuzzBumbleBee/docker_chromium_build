# Use 16.04 base
FROM ubuntu:16.04

# By Shane Francis
MAINTAINER Shane Francis <bigbeeshane@gmail.com>

# Install the base packages
RUN apt-get update && apt-get install -y build-essential curl git nano sudo python wget lsb-release software-properties-common

# Enable multiverse for msttcorefonts
RUN add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) multiverse" -y

# Add OpenJDK PPA for OpenJDK 1.7
RUN add-apt-repository ppa:openjdk-r/ppa -y

# apt-get update to be clean
RUN apt-get update

# Switch to the new user by default and make ~/ the working dir
ENV USER build
WORKDIR /home/${USER}/

# Add the build user, update password to build and add to sudo group
RUN useradd --create-home ${USER} && echo "${USER}:${USER}" | chpasswd && adduser ${USER} sudo

# Fix permissions on home
RUN chown -R ${USER}:${USER} /home/${USER}

USER ${USER}

# Setup dummy git config
RUN git config --global user.name "${USER}" && git config --global user.email "${USER}@localhost"

# Clone chromium depot tools and export
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
ENV PATH=$PATH:/home/build/depot_tools

# Use nano as the default editor (mainly for 'gn args')
ENV VISUAL=nano

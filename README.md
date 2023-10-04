# Debian install with i3wm

## Things I install that are not in the install script

- [WhatPulse](https://whatpulse.org/downloads/)
- [Synology Drive Client](https://www.synology.com/en-id/support/download)

## Installing

1. Download a [debian](https://debian.org) ISO, boot into the live environment and install debian.
2. Add sudo privileges to the user and install git.
```shell
su -
usermod -aG sudo USERNAME
su USERNAME
sudo apt install git
```
3. Setup ssh on the machine (used for cloning packer (nvim package manager))
4. Clone this repo and run the shell script.


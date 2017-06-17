#!/usr/bin/env sh
set -e
set -u

repoFilePath='/etc/yum.repos.d/overdrive.repo'
repoFileContent='[overdrive]
name=overdrive
#baseurl=https://Lin-Buo-Ren.github.io/overdrive/download/yum/overdrive
mirrorlist=https://Lin-Buo-Ren.github.io/overdrive/download/yum/overdrive/mirrorlist
#gpgkey not set as repository is unsigned
gpgcheck=0
enabled=1
protect=0'

if [ -t 1 ]; then
	printf '%s\n' "This script will install the yum repository 'overdrive'" "It will create or replace '$repoFilePath', update yum and display all packages in 'overdrive'." 'Press the [Enter] key to continue.'
	read -r garbage
fi

printf '%s' "$repoFileContent" | sudo -p "Password for %p is required to allow root to install '$repoFilePath': " tee "$repoFilePath" >/dev/null
sudo -p "Password for %p is required to allow root to update yum cache: " yum --quiet makecache
yum --quiet info overdrive 2>/dev/null

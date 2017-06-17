#!/usr/bin/env sh
set -e
set -u

if [ -t 1 ]; then
	printf '%s\n' 'This script will install the apt repository overdrive' 'It will change your apt keys, create or replace /etc/apt/sources.list.d/00overdrive.sources.list, install apt-transport-https and update apt.' 'Press the [Enter] key to continue.'
	read -r garbage
fi

sudo -p "Password for %p to allow root to update from new sources before installing apt-transport-https: " apt-get --quiet update
sudo -p "Password for %p to allow root to  apt-get install apt-transport-https (missing in Debian default installs)" apt-get install apt-transport-https

temporaryKeyFile="$(mktemp --tmpdir overdrive.key.XXXXXXXXX)"
trap 'rm -rf "$temporaryKeyFile"' EXIT HUP INT QUIT TERM
cat >"$temporaryKeyFile" <<EOF
EOF
sudo -p "Password for %p is required to allow root to install repository 'overdrive' public key to apt: " apt-key add "$temporaryKeyFile"

echo 'deb https://Lin-Buo-Ren.github.io/overdrive/download/apt overdrive multiverse' | sudo -p "Password for %p is required to allow root to install repository 'overdrive' apt sources list to '/etc/apt/sources.list.d/00overdrive.sources.list': " tee /etc/apt/sources.list.d/00overdrive.list >/dev/null
sudo -p "Password for %p to allow root to update from new sources: " apt-get --quiet update

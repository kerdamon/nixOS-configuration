#!/usr/bin/env bash
# This script is used to setup my configuration on macOS systems

{ # Prevent execution if this script was only partially downloaded

NIX_CONF_PATH="$HOME/Config/nix"
HOSTNAME="kmac5"
REPO_ADDRESS=https://github.com/kerdamon/nixOS-configuration.git

echo "Installing xcode-select"
xcode-select --install

echo "Setting up nix"

# setup nix
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

rm -rf $NIX_CONF_PATH
git clone $REPO_ADDRESS $NIX_CONF_PATH

sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake $NIX_CONF_PATH#$HOSTNAME

}
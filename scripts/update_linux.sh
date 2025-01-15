#!/usr/bin/env bash
trap "exit" INT # for ctrl + C to exit whole script

echo
echo "--> Updating eos (eos-update --nvidia --aur)"
echo
eos-update --nvidia --aur 

echo
echo "--> Updating home-manager flake (nix flake update --flake $MY_NIX_CONF_PATH)"
echo
nix flake update --flake $MY_NIX_CONF_PATH

echo
echo "--> Applying home-manager configuration (home-manager switch --flake $MY_NIX_CONF_PATH#generic-linux)"
echo
home-manager switch --flake $MY_NIX_CONF_PATH#generic-linux


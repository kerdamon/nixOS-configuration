#!/usr/bin/env bash
trap "exit" INT # for ctrl + C to exit whole script

highlight_color="\033[48;5;53m"
neutral_color="\033[0m"

echo
echo "${highlight_color}--> Updating eos$neutral_color (eos-update --nvidia --aur)"
echo
eos-update --nvidia --aur 

echo
echo "${highlight_color}Updating home-manager flake$neutral_color (nix flake update --flake $MY_NIX_CONF_PATH)"
echo
nix flake update --flake $MY_NIX_CONF_PATH

echo
echo "${highlight_color}Applying home-manager configuration$neutral_color (home-manager switch --flake $MY_NIX_CONF_PATH#generic-linux)"
echo
home-manager switch --flake $MY_NIX_CONF_PATH#generic-linux


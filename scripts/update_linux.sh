#!/usr/bin/env bash
trap "exit" INT # for ctrl + C to exit whole script

highlight_color="\033[48;5;53m"
neutral_color="\033[0m"

path_to_flake=$MY_NIX_CONF_PATH
hostname=$(hostname)

echo -e "\n${highlight_color}Updating eos$neutral_color (eos-update --nvidia --aur)\n"
eos-update --nvidia --aur 

echo -e "\n${highlight_color}Updating flake$neutral_color (nix flake update --flake $path_to_flake)\n"
nix flake update --flake $path_to_flake

echo -e "\n${highlight_color}Applying home-manager configuration$neutral_color (home-manager switch --flake $path_to_flake#$hostname)\n"
home-manager switch --flake $path_to_flake#$hostname


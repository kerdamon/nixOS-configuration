# This file contains Home Manager configuration specific to workstations (laptop, PC etc.)

{ ... }:
{
  imports = [
    ../shared/ssh.nix
  ];

  # rn obsidian is only available prebuilt for linux in nixpkgs
  # programs.obsidian.enable = true;

  programs.zellij.enable = true; # temporarily moved from terminal-environment.nix because I don't want this on servers. TODO move back there and make proper option
}

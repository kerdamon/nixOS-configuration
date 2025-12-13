# This file contains Home Manager configuration specific to workstations (laptop, PC etc.)

{ ... }:
{
  imports = [
    ../shared/ssh.nix
  ];

  # rn obsidian is only available prebuilt for linux in nixpkgs
  # programs.obsidian.enable = true;
}

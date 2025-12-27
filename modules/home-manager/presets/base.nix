# This file contains base Home Manager configuration shared across all systems

{ pkgs, ... }:
{
  imports = [
    ../shared/shell.nix
    ../shared/terminal-environment.nix
    ../shared/cli-editors.nix
    ../shared/git.nix
    ../shared/aliases.nix
    ../shared/cli-utils.nix
    ../shared/fonts.nix # TODO rethink if that should be in base
    ../shared/backup.nix
  ];

  home.packages = with pkgs; [
    croc
  ];

  home.file = {
    "tmp/.keep".text = "";
    "Data/.keep".text = "";
    "Files/.keep".text = "";
    "Secrets/.keep".text = "";
  };

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}

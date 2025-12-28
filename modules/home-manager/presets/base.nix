# This file contains base Home Manager configuration shared across all systems

{ pkgs, config, ... }:
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
    "Config/.keep".text = "";
    "Data/.keep".text = "";
    "Files/.keep".text = "";
    "Secrets/.keep".text = "";
  };

  # log off and log in after switching to apply changes
  home.sessionVariables = {
    "MY_NIX_CONF_PATH" = "${config.home.homeDirectory}/Config/nix";
  };

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}

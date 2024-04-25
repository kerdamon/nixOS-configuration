{ config, lib, pkgs, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
  '';
in
{
  home.username = "kered";
  home.homeDirectory = "/home/kered";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    obsidian
    audacity
    thefuck
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/hypr/hyprpaper.conf".source = ./dotfiles/hyprpaper.conf;
  };

  home.sessionVariables = { };

  programs.home-manager.enable = true;

  # My configuration

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
    settings = {
      exec-once = ''${startupScript}/bin/start'';
    };
  };

  nixpkgs.config.allowUnfree = true;

  ## shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "robbyrussell";
    };
  };

  ## notification deamon
  services.dunst.enable = true;
}


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
    # GUI apps
    obsidian
    audacity
    discord

    # CLI apps
    thefuck
    kalker
    devbox
    neofetch

    # system utils
    wlogout

    # dependencies
    nil
    hyprpaper
    hypridle
    hyprlock
  ];

  home.file = {
    ".config/hypr/hyprpaper.conf".source = ./dotfiles/hypr/hyprpaper.conf;
    ".config/hypr/hypridle.conf".source = ./dotfiles/hypr/hypridle.conf;
    ".config/hypr/hyprlock.conf".source = ./dotfiles/hypr/hyprlock.conf;
    ".config/waybar/config".source = ./dotfiles/waybar/config;
  };

  home.sessionVariables = {
    "NIXOS_CONF_PATH" = "/home/kered/Data/nixos-conf";
  };

  home.shellAliases = { # aliases for all shells
    "cdnix" = "cd $NIXOS_CONF_PATH";
  };

  programs.home-manager.enable = true;

  # My configuration

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./dotfiles/hypr/hyprland.conf;
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

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  ## notification deamon
  services.dunst.enable = true;

  ## Theming
  gtk = {
    enable = true;
    iconTheme.package = pkgs.gruvbox-plus-icons;
    iconTheme.name = "Gruvbox-Plus-Dark";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };
}


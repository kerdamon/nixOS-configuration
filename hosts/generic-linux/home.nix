{ config, pkgs, ... }:

{
  home.username = "kered";
  home.homeDirectory = "/home/kered";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # GUI
    obsidian
    postman
    devbox
    android-studio
    discord

    # terminal
    thefuck

    # contenerization (without root)
    colima
    docker
  ];

  home.file = {
  };

  home.sessionVariables = { # log off and log in after switching to apply changes
    "MY_NIX_CONF_PATH" = "/home/kered/Data/nix-conf";
    "ANDROID_HOME" = "/home/kered/Files/Android/Sdk";
    "GIT_EDITOR" = "vim";
  };

  home.shellAliases = { # aliases for all shells
    "cdnix" = "cd $MY_NIX_CONF_PATH";
    "hms" = "home-manager switch --flake $MY_NIX_CONF_PATH#generic-linux";
    "hm-news" = "home-manager news --flake .#generic-linux";
    "shasum" = "sha512sum"; # potential fix for colima requiring shasum command not available on system (available on perl package, but I don't want to install it if not necessary)
  };

  # programs

  programs.vim = {
    enable = true;
    settings = {
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "kerdamon";
    userEmail = "kwalas314@gmail.com";
  };
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      set -o vi
      bindkey "^R" history-incremental-search-backward
    '';
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

  programs.direnv.enable = true;
  programs.vscode.enable = true;

  programs.plasma = {
    enable = true;
    input.keyboard.repeatDelay = 300;
    input.keyboard.repeatRate = 60;
    kscreenlocker.timeout = 15;
  };
}

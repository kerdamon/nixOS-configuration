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

    # scripts
    (writeShellScriptBin "fzf-preview" (builtins.readFile ../../scripts/fzf-preview.sh))
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
    "cat" = "bat";
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
      # Following bindkey "^R" is to enable reverse search in vim mode, because it doesn't have this keybinding out of the box
      # It is comented because fzf is installed and fzf's zsh integration binds ctr + R to fuzzy find in history, therefore binding it here disables fzf
      # If fzf is uninstalled, this need to be uncommented for ctrl + R to launch reverse history search in vim mode
      # bindkey "^R" history-incremental-search-backward
    '';
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" "fzf" ];
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

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat.enable = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}

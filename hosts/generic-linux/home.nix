{ config, pkgs, ... }:

{
  home.username = "kered";
  home.homeDirectory = "/home/kered";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    obsidian
    postman
    devbox
    thefuck
  ];

  home.file = {
  };

  home.sessionVariables = {
    "NIXOS_CONF_PATH" = "/home/kered/.config/home-manager";
  };

  home.shellAliases = { # aliases for all shells
    "cdnix" = "cd $NIXOS_CONF_PATH";
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
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "robbyrussell";
    };
    sessionVariables = {
      ANDROID_HOME = "/home/kered/Android/Sdk/";
    };
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv.enable = true;
}

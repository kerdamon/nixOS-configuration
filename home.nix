{ config, pkgs, ... }:

{
  home.username = "kered";
  home.homeDirectory = "/home/kered";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
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

  programs.vim.enable = true;

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
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

}


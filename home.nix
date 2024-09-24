{ config, pkgs, ... }:

{
  home.username = "kered";
  home.homeDirectory = "/home/kered";

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    devbox
  ];

  home.file = {
  };

  home.sessionVariables = {
    ANDROID_HOME = "/home/kered/Android/Sdk";
  };

  programs.home-manager.enable = true;

  programs.vim.enable = true;
  programs.git.enable = true;
}

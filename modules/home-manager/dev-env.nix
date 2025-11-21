{ pkgs, ... }:
{
  home.packages = with pkgs; [
    devbox
  ];

  programs.direnv.enable = true;
}

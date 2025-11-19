{ pkgs, ... }:
{
  home.packages = with pkgs; [
    devbox
    postman
  ];
  programs.direnv.enable = true;
}

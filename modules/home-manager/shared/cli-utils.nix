{ pkgs, ... }:
{
  programs.ripgrep.enable = true;
  programs.mc.enable = true;

  home.packages = with pkgs; [
    neofetch
  ];
}

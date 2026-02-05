{ pkgs, ... }:
{
  programs.ripgrep.enable = true;
  programs.mc.enable = true;
  programs.btop.enable = true;

  home.packages = with pkgs; [
    neofetch
  ];
}

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    borgmatic
  ];
  services.borgmatic = {
    enable = true;
    frequency = "daily";
  };
}

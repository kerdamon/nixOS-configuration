{ pkgs, ... }:
{
  imports = [
    ../../modules/home-manager/presets/base.nix
    ../../modules/home-manager/presets/darwin.nix
    ../../modules/home-manager/presets/workstation.nix
    ../../modules/home-manager/presets/development.nix
  ];

  home.username = "kwalas";
  home.homeDirectory = "/Users/kwalas";

  home.packages = with pkgs; [
    discord
  ];
}

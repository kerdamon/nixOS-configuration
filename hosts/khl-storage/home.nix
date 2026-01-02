{ ... }:
{
  imports = [
    ../../modules/home-manager/presets/base.nix
    ../../modules/home-manager/presets/linux.nix
    ../../modules/home-manager/presets/server.nix
  ];

  home.username = "kwalas";
  home.homeDirectory = "/home/kwalas";

  home.file = {
    ".config/borgmatic.d/immich.yml".source = ./dotfiles/immich.borgmatic.yaml;
  };
}

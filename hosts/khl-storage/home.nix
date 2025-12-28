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

  home.shellAliases = {
    "nix-switch" = "home-manager switch --flake $MY_NIX_CONF_PATH#khl-storage"; # TODO  get current host from variable and put that to base
    "hm-news" = "home-manager news --flake $MY_NIX_CONF_PATH#khl-storage";
  };
}

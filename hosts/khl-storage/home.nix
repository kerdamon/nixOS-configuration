{ pkgs, config, ... }:
{
  imports = [
    ../../modules/home-manager/presets/base.nix
    ../../modules/home-manager/presets/linux.nix
    ../../modules/home-manager/presets/server.nix
  ];

  home.username = "kwalas";
  home.homeDirectory = "/home/kwalas";

  home.packages = with pkgs; [
    neofetch
  ];

  home.file = {
    ".config/borgmatic.d/data-services.yml".source = ./dotfiles/data-services.borgmatic.yaml;
  };

  # log off and log in after switching to apply changes
  home.sessionVariables = {
    "MY_NIX_CONF_PATH" = "${config.home.homeDirectory}/Config/nix"; # TODO put that to base
  };

  home.shellAliases = {
    "nix-switch" = "home-manager switch --flake $MY_NIX_CONF_PATH#khl-storage"; # TODO  get current host from variable and put that to base
    "hm-news" = "home-manager news --flake $MY_NIX_CONF_PATH#khl-storage";
  };
}

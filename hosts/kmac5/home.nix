{ ... }:
{
  imports = [
    ../../modules/home-manager/presets/base.nix
    ../../modules/home-manager/presets/darwin.nix
    ../../modules/home-manager/presets/workstation.nix
    ../../modules/home-manager/presets/development.nix
  ];

  home.username = "kwalas";
  home.homeDirectory = "/Users/kwalas";

  home.shellAliases = {
    "nix-switch" = "sudo darwin-rebuild switch --flake $MY_NIX_CONF_PATH#kmac5"; # TODO generalize for macOS (host is currently magic number)
  };
}

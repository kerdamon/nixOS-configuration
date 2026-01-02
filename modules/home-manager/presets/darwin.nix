# This file contains Home Manager configuration specific to macOS (Darwin) systems
# TODO move generic stuff to base and workstation stuff to workstation and make conditionals for darwin specific only

{ pkgs, hostName, ... }:
{
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    alacritty

    (writeShellScriptBin "nix-update-switch" (builtins.readFile ../../../scripts/update_mac.sh))
  ];

  home.file = {
    ".config/karabiner".source = ../../../dotfiles/karabiner;
    ".config/alacritty/alacritty.toml".source = ../../../dotfiles/alacritty.toml;
    ".config/borgmatic.d/data-local.yml".source = ../../../dotfiles/data-local.borgmatic.darwin.yaml; # TODO move to workstation or host specific
  };

  home.shellAliases = {
    "nix-switch" = "sudo darwin-rebuild switch --flake $MY_NIX_CONF_PATH#${hostName}";
  };
}

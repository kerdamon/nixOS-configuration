{ pkgs, ... }:
{
  imports = [
    ../../modules/home-manager/presets/base.nix
    ../../modules/home-manager/presets/darwin.nix
    ../../modules/home-manager/presets/development.nix
    ../../modules/home-manager/presets/workstation.nix
  ];

  home.username = "kwalas";
  home.homeDirectory = "/Users/kwalas";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    nil # needed for vscode nix linter to work

    # GUI apps
    alacritty

    (writeShellScriptBin "nix-update-switch" (builtins.readFile ../../scripts/update_mac.sh))
  ];

  home.file = {
    ".config/karabiner".source = ./dotfiles/karabiner;
    ".config/alacritty/alacritty.toml".source = ../../dotfiles/alacritty.toml;
  };

  # log off and log in after switching to apply changes
  home.sessionVariables = {
    "MY_NIX_CONF_PATH" = "/Users/kwalas/Config/nix";
    "GIT_EDITOR" = "vim";
  };

  home.shellAliases = {
    "nix-switch" = "sudo darwin-rebuild switch --flake $MY_NIX_CONF_PATH#kmac5";
  };
}

{ pkgs, ... }:
{
  imports = [
    ../../modules/home-manager/shell.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/ssh.nix
    ../../modules/home-manager/terminal-environment.nix
    ../../modules/home-manager/editors.nix
    ../../modules/home-manager/aliases.nix
    ../../modules/home-manager/fonts.nix
  ];

  home.username = "kwalas";
  home.homeDirectory = "/Users/kwalas";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    nil # needed for vscode nix linter to work
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

{
  config,
  pkgs,
  nixpkgs,
  ...
}:

{
  imports = [
    ../../modules/home-manager/shell.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/ssh.nix
    ../../modules/home-manager/terminal-environment.nix
  ];

  home.username = "kwalas";
  home.homeDirectory = "/Users/kwalas";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    vscode
    nil # needed for vscode nix linter to work

    # (writeShellScriptBin "update" (builtins.readFile ../../scripts/update_linux.sh)) # TODO introduce update script for macOS
  ];

  home.file = {
    ".config/karabiner".source = ./dotfiles/karabiner;
  };
}

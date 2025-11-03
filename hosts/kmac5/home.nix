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
  ];

  home.username = "kwalas";
  home.homeDirectory = "/Users/kwalas";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    vscode
    nil # needed for vscode nix linter to work
  ];

  home.file = {
    ".config/karabiner".source = ./dotfiles/karabiner;
  };
}

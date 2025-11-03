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
  ];

  home.username = "kwalas";
  home.homeDirectory = "/Users/kwalas";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    vscode
  ];
}

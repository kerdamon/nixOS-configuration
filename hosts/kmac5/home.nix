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
    ../../modules/home-manager/editors.nix
    ../../modules/home-manager/aliases.nix
  ];

  home.username = "kwalas";
  home.homeDirectory = "/Users/kwalas";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    nil # needed for vscode nix linter to work

    (writeShellScriptBin "update" (builtins.readFile ../../scripts/update_mac.sh))
  ];

  home.file = {
    ".config/karabiner".source = ./dotfiles/karabiner;
  };

  # log off and log in after switching to apply changes
  home.sessionVariables = {
    "MY_NIX_CONF_PATH" = "/Users/kwalas/Config/nixOS-configuration";
    "GIT_EDITOR" = "vim";
  };
}

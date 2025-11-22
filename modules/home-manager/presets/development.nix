{ pkgs, ... }:
{
  imports = [
    ../shared/dev-env.nix
  ];

  home.packages = with pkgs; [
    postman
    nil # needed for vscode nix linter to work
  ];

  home.shellAliases = {
    "cdd" = "cd ~/Development";
  };

  programs.vscode.enable = true;

  # TODO activation scripts create ~/Development
}

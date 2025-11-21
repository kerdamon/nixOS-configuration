{ ... }:
{
  imports = [
    ../shared/shell.nix
    ../shared/terminal-environment.nix
    ../shared/cli-editors.nix
    ../shared/git.nix
    ../shared/aliases.nix
    ../shared/cli-utils.nix
    ../shared/fonts.nix # TODO rethink if that should be in base
  ];
}

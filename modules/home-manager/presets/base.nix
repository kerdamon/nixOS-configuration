{ ... }:
{
  imports = [
    ../shell.nix
    ../terminal-environment.nix
    ../cli-editors.nix
    ../git.nix
    ../aliases.nix
    ../cli-utils.nix
    ../fonts.nix # TODO rethink if that should be in base
  ];
}

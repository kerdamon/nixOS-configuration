# This file contains Home Manager configuration specific to workstations (laptop, PC etc.)

{ lib, pkgs, ... }:
{
  imports = [
    ../shared/ssh.nix
  ];

  home.packages =
    with pkgs;
    [
      obsidian
    ]
    ++ lib.optionals stdenv.isDarwin [
      notion-app
    ];

  programs.zellij = {
    enable = true;
    enableZshIntegration = false; # enableZshIntegration causes zellij to be launched in every terminal, also vscode, where I don't want it. I moved zellij init to shell.nix for now.
  };

  # TODO move zellij init here (zsh with if for vscode)
}

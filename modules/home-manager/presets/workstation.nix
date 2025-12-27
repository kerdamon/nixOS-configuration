# This file contains Home Manager configuration specific to workstations (laptop, PC etc.)

{ ... }:
{
  imports = [
    ../shared/ssh.nix
  ];

  # programs.obsidian.enable = true; # rn obsidian is only available prebuilt for linux in nixpkgs

  programs.zellij = {
    enable = true;
    enableZshIntegration = false; # enableZshIntegration causes zellij to be launched in every terminal, also vscode, where I don't want it. I moved zellij init to shell.nix for now.
  };

  # TODO move zellij init here (zsh with if for vscode)
}

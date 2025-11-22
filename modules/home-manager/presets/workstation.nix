{ ... }:
{
  imports = [
    ../shared/ssh.nix
  ];

  # rn obsidian is only available prebuilt for linux in nixpkgs
  # programs.obsidian.enable = true;
}

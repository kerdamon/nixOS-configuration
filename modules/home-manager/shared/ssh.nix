{ ... }:
{
  programs.ssh = {
    enable = true;
    extraConfig = builtins.readFile ../../../dotfiles/ssh.conf;
  };
}

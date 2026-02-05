{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    # enableGitIntegration = true; # TODO debug this, doesn't work for some reason, maybe programs.git.iniContent used by this option doesn't exist
    extraConfig = (builtins.readFile ../../../dotfiles/kitty.conf);
  };

  # Util for copying kitty terminfo from local to server over ssh. Without this using kitty term would glitch.
  # Needed to be done before first connection to a new server or after kitty breaking update.
  # https://sw.kovidgoyal.net/kitty/kittens/ssh/#copying-terminfo-files-manually
  home.packages = [
    (pkgs.writeShellScriptBin "ssh-copy-kitty-terminfo" ''
      if [ -z "$1" ]; then
        echo "Usage: ssh-copy-terminfo <hostname>"
        exit 1
      fi
      infocmp -a xterm-kitty | ssh "$1" tic -x -o \~/.terminfo /dev/stdin
    '')
  ];

}

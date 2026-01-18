{ ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    # enableGitIntegration = true; # TODO debug this, doesn't work for some reason, maybe programs.git.iniContent used by this option doesn't exist
    extraConfig = (builtins.readFile ../../../dotfiles/kitty.conf);
  };
}

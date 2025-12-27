{ ... }:
{
  programs.bat.enable = true;
  home.shellAliases = {
    "cat" = "bat";
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };
}

{ ... }:
{
  programs.zellij.enable = true; # enableZshIntegration is not used here, because it launched in vscode. It was moved to shell.nix. TODO move this here (make own enableZshIntegration)
  programs.bat.enable = true;

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

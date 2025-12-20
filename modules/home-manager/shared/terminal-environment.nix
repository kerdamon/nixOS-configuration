{ ... }:
{
  # ad.1 enableZshIntegration is not used here, because it caused zellij to be launched in every terminal, also vscode, where I don't want it. I moved zellij init to shell.nix for now.
  # TODO this custom option here (make own enableZshIntegration)
  # ad.2 temporary moved to workstation.nix because I don't want this on servers.
  # TODO make terminal-environment.nix proper hm module and include this as an option, then in workstations use this module with zellij enabled and in servers use this module with zellij disabled.
  # programs.zellij.enable = true;

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

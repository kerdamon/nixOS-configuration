{ ... }:
{
  programs.vim = {
    enable = true;
    settings = {
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
    };
  };

  programs.neovim = {
    enable = true;
    extraConfig = ''
      set tabstop=2
      set shiftwidth=2
      set expandtab
    '';
  };

  programs.vscode.enable = true; # TODO move to development and rename to cli-editors
}

{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    (writeShellScriptBin "fzf-preview" (builtins.readFile ../../../scripts/fzf-preview.sh)) # TODO change to writeShellApplication and declare fzf as dependency
  ];

  home.file = {
    ".p10k.zsh".source = ../../../dotfiles/p10k.zsh;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    # TODO change this to  zsh-vi-mode plugin
    defaultKeymap = "viins"; # vi mode
    # TODO extract initContent to a dotfile
    # TODO split that into parts and include in modules it is needed (like zellij launch where zellij is enabled)
    initContent = lib.mkMerge [
      # TODO think about enabling powerlevel10k instant prompt here. It didn't work with my zellij setup, so i left it disabled for now
      (lib.mkOrder 1000 (builtins.readFile ../../../dotfiles/zshrc_extra.zsh))
      (lib.mkAfter "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh")
    ];

    # plugin manager
    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-completions"
        "getantidote/use-omz" # oh-my-zsh dependencies - enables to use ozm plugins
        # "ohmyzsh/ohmyzsh path:lib" # omz core functionalities (if I understand correctly)
        "ohmyzsh/ohmyzsh path:plugins/git"
        "ohmyzsh/ohmyzsh path:plugins/command-not-found" # TODO doesn't work, check how to fix this
        "Aloxaf/fzf-tab"
        "romkatv/powerlevel10k" # prompt
      ];
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}

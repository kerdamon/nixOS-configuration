{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    (writeShellScriptBin "fzf-preview" (builtins.readFile ../../../scripts/fzf-preview.sh)) # TODO change to writeShellApplication and declare fzf as dependency
  ];

  home.file = {
    ".p10k.zsh".source = ../../../dotfiles/p10k.zsh;
  };

  home.sessionVariables = {
    ZVM_SYSTEM_CLIPBOARD_ENABLED = "true";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    initContent = lib.mkMerge [
      # TODO think about enabling powerlevel10k instant prompt here. It didn't work with my zellij setup, so i left it disabled for now
      (lib.mkOrder 1000 (builtins.readFile ../../../dotfiles/zshrc_extra.zsh)) # TODO split that into parts and include in modules it is needed (like zellij launch where zellij is enabled)
      (lib.mkAfter "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh")
    ];

    # plugin manager
    antidote = {
      enable = true;
      plugins = [
        "mattmc3/ez-compinit" # handles compinit initialization - needed for completions to work properly
        "zsh-users/zsh-completions kind:fpath path:src"
        "getantidote/use-omz" # oh-my-zsh dependencies - enables to use ozm plugins
        "ohmyzsh/ohmyzsh path:plugins/git"
        "ohmyzsh/ohmyzsh path:plugins/command-not-found"
        "Aloxaf/fzf-tab"
        "romkatv/powerlevel10k" # prompt
        "jeffreytse/zsh-vi-mode"
        "zdharma-continuum/fast-syntax-highlighting kind:defer"
      ];
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellScriptBin "fzf-preview" (builtins.readFile ../../scripts/fzf-preview.sh))
    (writeShellScriptBin "update" (builtins.readFile ../../scripts/update_linux.sh))
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    defaultKeymap = "viins"; # vi mode
    initContent = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'                          # case insensitive matching
      zstyle ':completion:*' menu no                                                  # don't show completion menu (since I am using fzf-tab plugin)
      zstyle ':completion:*:git-checkout:*' sort false                                # don't mess with order of git checkout targets
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'   # preview for cd command
      zstyle ':fzf-tab:*' use-fzf-default-opts yes                                    # To make fzf-tab follow FZF_DEFAULT_OPTS
      zstyle ':fzf-tab:*' switch-group '<' '>'                                        # switch group using `<` and `>`
      zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup                                  # use tmux popup

      # nice previews for git. Requires delta.
      zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
      zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview 'case "$group" in "modified file") git diff $word | delta ;; "recent commit object name") git show --color=always $word | delta ;; *) git log --color=always $word ;; esac'

      if [[ -z "$TERM_PROGRAM" || "$TERM_PROGRAM" != "vscode" ]]; then
        eval "$(zellij setup --generate-auto-start zsh)"
      fi
    '';
    antidote = { # plugin manager
      enable = true;
      plugins = [
        "zsh-users/zsh-completions"
        "getantidote/use-omz" # oh-my-zsh dependencies - enables to use ozm plugins
        # "ohmyzsh/ohmyzsh path:lib" # omz core functionalities (if I understand correctly)
        "ohmyzsh/ohmyzsh path:plugins/git"
        "ohmyzsh/ohmyzsh path:plugins/command-not-found" #TODO doesn't work, check how to fix this
        "Aloxaf/fzf-tab"
      ];
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
alias -g ...=../..
alias -g ....=../../..
alias -g .....=../../../..
alias -g ......=../../../../..

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'                          # case insensitive matching
zstyle ':completion:*' menu no                                                  # don't show completion menu (since I am using fzf-tab plugin)
zstyle ':completion:*:git-checkout:*' sort false                                # don't mess with order of git checkout targets
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'   # preview for cd command
zstyle ':fzf-tab:*' use-fzf-default-opts yes                                    # To make fzf-tab follow FZF_DEFAULT_OPTS
zstyle ':fzf-tab:*' switch-group '<' '>'                                        # switch group using `<` and `>`

# nice previews for git. Requires delta.
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview 'case "$group" in "modified file") git diff $word | delta ;; "recent commit object name") git show --color=always $word | delta ;; *) git log --color=always $word ;; esac'

bindkey -M vicmd '/' fzf-history-widget
bindkey ' ' magic-space

function zvm_after_init() {
  bindkey -M viins '^R' fzf-history-widget # fix for fzf in reverse search, since zsh-vi-mode ovverides it. https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file#execute-extra-commands
}

# open zellij if it is installed and terminal is not vscode
[[ -z "$TERM_PROGRAM" || "$TERM_PROGRAM" != "vscode" ]] && command -v zellij &>/dev/null && eval "$(zellij setup --generate-auto-start zsh)"

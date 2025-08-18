{ config, pkgs, ... }:

{
  home.username = "kered";
  home.homeDirectory = "/home/kered";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;
  nixpkgs.config.allowUnfree = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono

    # GUI
    obsidian
    postman
    discord
    rofi-wayland

    # cli
    mc
    devbox

    # contenerization (without root)
    colima
    docker

    # scripts
    (writeShellScriptBin "fzf-preview" (builtins.readFile ../../scripts/fzf-preview.sh))
    (writeShellScriptBin "update" (builtins.readFile ../../scripts/update_linux.sh))
  ];

  home.file = {
    ".config/kitty/kitty.conf".source = ../../dotfiles/kitty.conf;
  };

  home.sessionVariables = { # log off and log in after switching to apply changes
    "MY_NIX_CONF_PATH" = "/home/kered/Data/nix-conf";
    "ANDROID_HOME" = "/home/kered/Files/Android/Sdk";
    "GIT_EDITOR" = "vim";
  };

  home.shellAliases = { # aliases for all shells
    "cdt" = "cd ~/tmp";
    "cdnix" = "cd $MY_NIX_CONF_PATH";
    "hms" = "home-manager switch --flake $MY_NIX_CONF_PATH#generic-linux";
    "hm-news" = "home-manager news --flake $MY_NIX_CONF_PATH#generic-linux";
    "shasum" = "sha512sum"; # potential fix for colima requiring shasum command not available on system (available on perl package, but I don't want to install it if not necessary)
    "cat" = "bat";
    "open" = "kde-open $(fzf -m --preview='fzf-preview {}')";
  };

  # programs

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

  programs.git = {
    enable = true;
    userName = "kerdamon";
    userEmail = "kwalas314@gmail.com";
    delta.enable = true; # program for nice diff visualisation. Also used in fzf-tab previews.
  };
  
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

  programs.direnv.enable = true;
  programs.vscode.enable = true;

  programs.plasma = {
    enable = true;
    input.keyboard.repeatDelay = 300;
    input.keyboard.repeatRate = 60;
    input.keyboard.numlockOnStartup = "on";
    kscreenlocker.timeout = 15;
    configFile = {
      kdeglobals.General.TerminalApplication = "kitty";
      kdeglobals.General.TerminalService = "kitty.desktop";
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = builtins.readFile ../../dotfiles/ssh.conf;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat.enable = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.ripgrep.enable = true;
  # programs.kitty.enable = true; # doesn't work
}

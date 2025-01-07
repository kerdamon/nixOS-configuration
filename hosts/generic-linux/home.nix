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
    devbox
    android-studio
    discord

    # terminal
    mc

    # contenerization (without root)
    colima
    docker

    # scripts
    (writeShellScriptBin "fzf-preview" (builtins.readFile ../../scripts/fzf-preview.sh))
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
    "hm-news" = "home-manager news --flake .#generic-linux";
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

  programs.neovim.enable = true;

  programs.git = {
    enable = true;
    userName = "kerdamon";
    userEmail = "kwalas314@gmail.com";
  };
  
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins"; # vi mode
    initExtra = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case insensitive matching
    '';
    antidote = { # plugin manager
      enable = true;
      plugins = [
        "zsh-users/zsh-completions"
	"getantidote/use-omz" # oh-my-zsh dependencies - enables to use ozm plugins
        # "ohmyzsh/ohmyzsh path:lib" # omz core functionalities (if I understand correctly)
	"ohmyzsh/ohmyzsh path:plugins/git"
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
    kscreenlocker.timeout = 15;
    configFile = {
      kdeglobals.General.TerminalApplication = "kitty";
      kdeglobals.General.TerminalService = "kitty.desktop";
    };
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

  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
  };
}

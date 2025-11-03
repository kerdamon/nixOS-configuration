{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/shell.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/ssh.nix
  ];

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
    affine

    # cli
    mc
    devbox

    # contenerization (without root)
    colima
    docker

    # libraries
    libsForQt5.kconfig

    # scripts
    (writeShellScriptBin "fzf-preview" (builtins.readFile ../../scripts/fzf-preview.sh))
    (writeShellScriptBin "update" (builtins.readFile ../../scripts/update_linux.sh))
  ];

  home.file = {
    ".config/kitty/kitty.conf".source = ../../dotfiles/kitty.conf;
    ".config/autostart/ueli.desktop".source = ../../dotfiles/ueli-autostart.desktop;
  };

  # log off and log in after switching to apply changes
  home.sessionVariables = {
    "MY_NIX_CONF_PATH" = "/home/kered/Data/nix-conf";
    "ANDROID_HOME" = "/home/kered/Files/Android/Sdk";
    "GIT_EDITOR" = "vim";
  };

  # aliases for all shells
  home.shellAliases = {
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

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat.enable = true;

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.ripgrep.enable = true;

  programs.zellij.enable = true;
}

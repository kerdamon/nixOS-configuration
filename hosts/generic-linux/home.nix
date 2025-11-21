{ pkgs, ... }:
{
  imports = [
    ../../modules/home-manager/presets/base.nix
    ../../modules/home-manager/presets/linux.nix
    ../../modules/home-manager/presets/development.nix
    ../../modules/home-manager/presets/workstation.nix
  ];

  home.username = "kered";
  home.homeDirectory = "/home/kered";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # GUI
    obsidian
    discord
    affine

    # cli
    mc

    # contenerization (without root)
    colima
    docker

    # libraries
    libsForQt5.kconfig

    # scripts
    (writeShellScriptBin "nix-update-switch" (builtins.readFile ../../scripts/update_linux.sh))
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

  home.shellAliases = {
    "nix-switch" = "home-manager switch --flake $MY_NIX_CONF_PATH#generic-linux";
    "hm-news" = "home-manager news --flake $MY_NIX_CONF_PATH#generic-linux";
    "open" = "kde-open $(fzf -m --preview='fzf-preview {}')";

    "shasum" = "sha512sum"; # potential fix for colima requiring shasum command not available on system (available on perl package, but I don't want to install it if not necessary)
  };

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
}

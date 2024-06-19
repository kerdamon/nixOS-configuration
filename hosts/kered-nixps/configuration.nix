# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./main-user.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixps"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "pl_PL.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "pl";
  #   variant = "";
  # };

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ]; # Brother printer drivers. Printer was not working on generic drivers.

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.kered = {
  #   isNormalUser = true;
  #   description = "kered";
  #   extraGroups = [ "networkmanager" "wheel" ];
  #   packages = with pkgs; [
  #     firefox
    #  thunderbird
  #   ];
  # };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
    vscode
    pavucontrol
    cinnamon.nemo

    kitty
    rofi-wayland
    git
    vim
    brightnessctl
    playerctl # controls players, toggle play-stop etc.
    waybar
    wl-clipboard # cli clipboard
    unzip

    # screenshots and recording screen
    grim # screenshot
    slurp # select area for screenshot
    swappy # quick and simple editor for images (e.g. screenshots)
    imagemagick # "convert" command for manipulating images in cli as streams
    wf-recorder # cli for recording screen
  ];

  fonts.packages = with pkgs; [
    font-awesome
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # My configuration

  ## Users
  main-user.enable = true;
  main-user.userName = "kered";

  ## Home manager
  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "kered" = import ./home.nix;
    };
  };

  ## Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # force electron app to use wayland on NixOS. On other systems, env variable for this should be ELECTRON_OZONE_PLATFORM_HINT = "wayland"

  ## Hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland; # force to use package from flake, not from nixpkgs
  };

  ## Desktop portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # hyprland enables xdg-desktop-portal-hyprland, which does not support file picker. Adding this alongside is recommended by hyprland wiki 
  };

  ## Waybar
  # programs.waybar.enable = true;

  ## Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ## Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  ## Zsh
  programs.zsh.enable = true;

  ## run `nixos-rebuild switch --upgrade` once a day
  system.autoUpgrade.enable = true;

  hardware.opengl.enable = true;

  ## keyd
  services.keyd.enable = true;
  services.keyd.keyboards = {
    builtinKeyboard = {
      ids = ["*"];
      settings = {
        main = {
          capslock = "overload(hyper, esc)"; # capslock goes into hyper mode (defined below) when held, and acts like esc when tapped
          "102nd" = "leftmeta";
        };
        "hyper:C" = { # definition of hyper mode. :C means that it works as a control for any other key that is not defined below
          h = "left";
          j = "down";
          k = "up";
          l = "right";
          esc = "capslock"; # esc in hyper mode gives capslock
        };
      };
    };
  };

  ## np-applet
  programs.nm-applet.enable = true;

  ## auto discovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  ## Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  ## fingerprint login
  # services.fprintd.enable = true;
  # security.pam.services.swaylock = {};
  # security.pam.services.swaylock.fprintAuth = true;

  ## don’t shutdown when power button is short-pressed
  services.logind.powerKey = "lock";

  ## docker
  virtualisation.docker.enable = true;

  ## nix helper (nh)
  programs.nh = {
    enable = true;
    flake = "/home/kered/Data/nixos-conf";
  };

  ## stylix
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Original-Classic";
  stylix.cursor.size = 24;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/classic-dark.yaml"; #theme gallery: https://tinted-theming.github.io/base16-gallery/
  stylix.image = ./wallpapers/2.jpg;
  stylix.fonts.sizes.applications = 10;

  services.power-profiles-daemon.enable = true;
}

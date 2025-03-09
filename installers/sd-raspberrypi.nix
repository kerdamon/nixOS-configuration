{ pkgs, ... }:
let
  wifi_ssid = (import ./wifi.conf).ssid;
  wifi_psk = (import ./wifi.conf).psk;
  ssh_public_key = (builtins.readFile ./ssh.key.pub);
in {
  imports = [ <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix> ];

  system.stateVersion = "24.11";

  networking = {
    hostName = "raspi-nix";
    wireless = {
      enable = true;
      networks.${wifi_ssid}.psk = wifi_psk;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  users.users.kwalas = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ neovim git ];
    openssh.authorizedKeys.keys = [ ssh_public_key ];
    initialHashedPassword = "";
  };
}


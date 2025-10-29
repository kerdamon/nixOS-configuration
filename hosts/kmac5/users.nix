{ config, pkgs, home-manager, ... }:

{
  users.users.kwalas = {
    name = "kwalas";
    home = "/Users/kwalas";
  };

  home-manager.users.kwalas = import ./home.nix;
}

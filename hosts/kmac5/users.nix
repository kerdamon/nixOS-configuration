{
  config,
  pkgs,
  home-manager,
  ...
}:

{
  system.primaryUser = "kwalas";
  users.users.kwalas = {
    name = "kwalas";
    home = "/Users/kwalas";
  };
  home-manager.users.kwalas = import ./home.nix;
}

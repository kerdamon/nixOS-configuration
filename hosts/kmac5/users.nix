{ hostName, ... }:
{
  # TODO extract kwalas into a variable in flake
  system.primaryUser = "kwalas";
  users.users.kwalas = {
    name = "kwalas";
    home = "/Users/kwalas";
  };
  home-manager = {
    users.kwalas = import ./home.nix;
    extraSpecialArgs = {
      inherit hostName;
    };
  };
}

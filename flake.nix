{
  description = "Kered config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      darwin,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      ...
    }@inputs:
    let
      pkgs-x68-linux = nixpkgs.legacyPackages."x86_64-linux";
      pkgs-aarch64-linux = nixpkgs.legacyPackages."aarch64-linux";
      hostname-generic-linux = "generic-linux";
      hostname-khl-storage = "khl-storage";
      hostname-kmac5 = "kmac5";
    in
    {
      homeConfigurations.${hostname-generic-linux} = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs-x68-linux;
        modules = [
          ./hosts/${hostname-generic-linux}/home.nix
          inputs.plasma-manager.homeManagerModules.plasma-manager
        ];
        extraSpecialArgs = {
          hostName = hostname-generic-linux;
        };
      };

      homeConfigurations.${hostname-khl-storage} = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs-aarch64-linux;
        modules = [
          ./hosts/${hostname-khl-storage}/home.nix
        ];
        extraSpecialArgs = {
          hostName = hostname-khl-storage;
        };
      };

      darwinConfigurations.${hostname-kmac5} = darwin.lib.darwinSystem {
        modules = [
          ./hosts/${hostname-kmac5}/configuration.nix
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          {
            # TODO this probably coult be put into configuration.nix
            nix-homebrew = {
              enable = true;
              # enableRosetta = true;
              user = "kwalas"; # TODO unhardcode magic value
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
              };
              mutableTaps = false; # disable imperative brew tap
            };
          }
          (
            { config, ... }:
            {
              homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
            }
          )
        ];
        specialArgs = {
          inherit home-manager self;
          hostName = hostname-kmac5;
        };
      };
    };
}

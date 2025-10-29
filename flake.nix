{
  description = "Kered config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
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

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.nixps = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/kered-nixps/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };

      darwinConfigurations.kmac5 = darwin.lib.darwinSystem {
        modules = [
          ./hosts/kmac5/configuration.nix
          {
            system.configurationRevision = self.rev or self.dirtyRev or null; #metadata - reference flake commit in system generation
          }
          home-manager.darwinModules.home-manager
        ];
        specialArgs = {
          inherit home-manager;
        };
      };

      homeConfigurations."kubuxps-kered" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./hosts/kubuxps/home.nix ];
      };
      
      homeConfigurations."generic-linux" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./hosts/generic-linux/home.nix
          inputs.plasma-manager.homeManagerModules.plasma-manager
        ];
      };
    };
}


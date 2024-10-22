{
  description = "Kered config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
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

      homeConfigurations."kubuxps-kered" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./hosts/kubuxps/home.nix ];
      };
      
      homeConfigurations."generic-linux" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./hosts/generic-linux/home.nix ];
      };
    };
}


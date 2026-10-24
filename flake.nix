{
  description = "NixOS minimal config flake made for The Teratoma";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      globalModules = [
        ./modules/nixos/common
      ];
    in {
      nixosConfigurations = {
        seraphindisguise = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = globalModules ++ [
            ./hosts/seraphindisguise/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}

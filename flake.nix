{
  description = "Ryan's NixOS Flake";

  inputs = {

    # Official NixOS package sources
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";

    # nixos-hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    # home-manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixos-hardware, ... }@inputs: rec {

    nixosConfigurations = {
      "Xavers-nixDesktop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          nixpkgs-stable = import nixpkgs-stable {inherit system; config.allowUnfree = true;};
        };

        modules = [
          ./shared
          ./hosts/Xavers-nixDesktop
        ];
      };
      "Xavers-Laptop" = nixpkgs.lib.nixosSystem  rec {
        system = "x86_64-linux";

        specialArgs = {
          nixpkgs-stable = import nixpkgs-stable {inherit system; config.allowUnfree = true;};
        };

        modules = [
          ./shared
          ./hosts/Xavers-Laptop
          nixos-hardware.nixosModules.framework
        ];
      };
    };
  };
}

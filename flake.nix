{
  description = "Ryan's NixOS Flake";

  inputs = {

    # Official NixOS package sources
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }@inputs: rec {

    nixosConfigurations = {
      "Xavers-nixDesktop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./shared
          ./hosts/Xavers-nixDesktop
        ];
      };
      "Xavers-Laptop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./shared
          ./hosts/Xavers-Laptop
          nixos-hardware.nixosModules.framework
        ];
      };
    };
  };
}

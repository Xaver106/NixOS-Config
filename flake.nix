{
  description = "Xavers NixOS configuration";

  inputs = {

    # Official NixOS package sources
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";

    # nixos-hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixos-hardware, ... }@inputs: rec {

    nixosConfigurations = {
      "Xavers-nixDesktop" = nixpkgs.lib.nixosSystem rec {
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

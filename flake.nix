# Inspired by https://nixos-and-flakes.thiscute.world/ from https://github.com/ryan4yin

{
  description = "Xavers NixOS configuration";

  inputs = {

    # Official NixOS package sources
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";


    # nixos-hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs: let
    hm-defaults = {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    };
  in rec {

    nixosConfigurations = {
      "Xavers-nixDesktop" = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        modules = [
          ./shared
          ./hosts/Xavers-nixDesktop
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-gpu-nvidia-nonprime

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.xaver106 = import ./home/xaver106;
          }
        ];
      };
      "Xavers-Laptop" = nixpkgs.lib.nixosSystem  rec {
        system = "x86_64-linux";

        modules = [
          ./shared
          ./hosts/Xavers-Laptop
          nixos-hardware.nixosModules.framework-11th-gen-intel

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.xaver106 = import ./home/xaver106;
          }
        ];
      };
    };
  };
}

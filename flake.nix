# Inspired by https://nixos-and-flakes.thiscute.world/ from https://github.com/ryan4yin

{
  description = "Xavers NixOS configuration";

  inputs = {

    # Official NixOS package sources
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";

    # nixos-hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, catppuccin, ... }@inputs: let
    inherit (self) outputs;
  in rec {

    /*===== Overlays =====*/
    overlays = import ./overlays {inherit inputs;};

    /******* Nixos Configurations *******/
    nixosConfigurations = {

      "Xavers-nixDesktop" = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        # Pass all Inputs to the modules
        specialArgs = {inherit inputs outputs;};

        modules = [
          ./shared
          ./hosts/Xavers-nixDesktop
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
          catppuccin.nixosModules.catppuccin

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.xaver106.imports = [
              ./home/xaver106
              catppuccin.homeManagerModules.catppuccin
            ];
          }
        ];
      };

      "Xavers-Laptop" = nixpkgs.lib.nixosSystem  rec {
        system = "x86_64-linux";

        # Pass all Inputs to the modules
        specialArgs = {inherit inputs outputs;};

        modules = [
          ./shared
          ./hosts/Xavers-Laptop
          nixos-hardware.nixosModules.framework-11th-gen-intel
          catppuccin.nixosModules.catppuccin

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.xaver106.imports = [
              ./home/xaver106
              catppuccin.homeManagerModules.catppuccin
            ];
          }
        ];
      };
    };
  };
}

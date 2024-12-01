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

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      catppuccin,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    rec {

      # ===== Overlays =====
      overlays = import ./overlays { inherit inputs; };

      /**
        ***** Nixos Configurations ******
      */
      nixosConfigurations = {

        "Xavers-nixDesktop" = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";

          # Pass all Inputs to the modules
          specialArgs = { inherit inputs outputs; };

          modules = [
            ./shared
            ./hosts/Xavers-nixDesktop
            ./users/xaver106
          ];
        };

        "Xavers-Laptop" = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";

          # Pass all Inputs to the modules
          specialArgs = { inherit inputs outputs; };

          modules = [
            ./shared
            ./hosts/Xavers-Laptop
            ./users/xaver106
          ];
        };
      };
    };
}

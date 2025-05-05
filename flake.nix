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

    # Sops Nix
    sops-nix.url = "github:Mic92/sops-nix";
    # optional, not necessary for the module
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";

    # nixos-hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  };

  outputs =
    {
      self,
      nixpkgs,
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
            ./hosts/Xavers-nixDesktop
            ./users/xaver106
          ];
        };

        "Xavers-Laptop" = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";

          # Pass all Inputs to the modules
          specialArgs = { inherit inputs outputs; };

          modules = [
            ./hosts/Xavers-Laptop
            ./users/xaver106
          ];
        };
      };
    };

  nixConfig = {

    # Extra Cache Servers
    extra-substituters = [
      # nix community's cache server
      "https://nix-community.cachix.org"
      "https://catppuccin.cachix.org"
    ];

    extra-trusted-public-keys = [
      # nix community's cache server public key
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
    ];
  };
}

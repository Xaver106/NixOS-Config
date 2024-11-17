{ config, pkgs, lib, ... }:
with lib;

let 
  cfg = config.shared.specialisations;
in {
  imports = [
    ./isolated.nix
  ];

  options.shared.specialisations = {
    enable = mkEnableOption "All packages";
  };

   config = {
    shared.specialisations = {
      isolated.enable = mkDefault cfg.enable; 
    };
  };
}

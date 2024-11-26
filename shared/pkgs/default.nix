{ config, pkgs, lib, ... }:
with lib;

let 
  cfg = config.shared.pkgs;
in {
  imports = [
    ./base.nix
    ./calculators.nix
    ./dev.nix
    ./latex.nix
    ./security.nix
    ./gui
  ];

  options.shared.pkgs = {
    enable = mkEnableOption "All packages";
  };

  config = {
    shared.pkgs = {
      base.enable = mkDefault cfg.enable;
      calculators.enable = mkDefault cfg.enable;
      dev.enable = mkDefault cfg.enable;
      gui.enable = mkDefault cfg.enable;
      latex.enable = mkDefault cfg.enable;
      security.enable = mkDefault cfg.enable;
    };
  };
}

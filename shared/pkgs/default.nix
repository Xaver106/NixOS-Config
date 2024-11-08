{ config, pkgs, lib, ... }:
with lib;

let 
  cfg = config.shared.pkgs;
in {
  imports = [
    ./cli
    ./gui
  ];

  options.shared.pkgs = {
    enable = mkEnableOption "All packages";
  };

  config = {
    shared.pkgs = {
      cli.enable = mkDefault cfg.enable;
      gui.enable = mkDefault cfg.enable;
    };
  };
}

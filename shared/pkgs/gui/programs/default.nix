{ config, pkgs, lib, ... }:
with lib;

let 
  cfg = config.shared.pkgs.gui.programs;
in {
  imports = [
    ./firefox.nix
    ./obs.nix
  ];

  options.shared.pkgs.gui.programs = {
    enable = mkEnableOption "GUI Programs";
  };

  config = {
    shared.pkgs.gui.programs = {
      firefox.enable = mkDefault cfg.enable;
      obs.enable = mkDefault cfg.enable;
    };
  };
}

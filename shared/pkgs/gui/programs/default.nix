{ config, pkgs, lib, ... }:
with lib;

let 
  cfg = config.shared.pkgs.gui.programs;
in {
  imports = [
    ./obs.nix
    ./firefox.nix
    ./rmview.nix
  ];

  options.shared.pkgs.gui.programs = {
    enable = mkEnableOption "GUI Programs";
  };

  config = {
    shared.pkgs.gui.programs = {
      obs.enable = mkDefault cfg.enable;
      firefox.enable = mkDefault cfg.enable;
      rmview.enable = mkDefault cfg.enable;
    };
  };
}
{ config, pkgs, lib, ... }:
with lib;

let 
  cfg = config.shared.pkgs.gui.specialized;
in {
  imports = [
    ./printing.nix
    ./system.nix
  ];

  options.shared.pkgs.gui.specialized = {
    enable = mkEnableOption "Specialized packages";
  };

  config = {
    shared.pkgs.gui.specialized = {
      printing.enable = mkDefault cfg.enable;
      system.enable = mkDefault cfg.enable;
    };
  };
}
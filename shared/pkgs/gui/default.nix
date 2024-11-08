{ config, pkgs, lib, ... }:
with lib;

let 
  cfg = config.shared.pkgs.gui;
in {
  imports = [
    ./desktop.nix
    ./dev.nix
    ./internet.nix
    ./communication.nix
    ./media.nix
    ./gaming.nix
    ./productivity.nix
    ./security.nix
    ./specialized
    ./programs
  ];

  options.shared.pkgs.gui = {
    enable = mkEnableOption "GUI packages";
  };

  config = {
    shared.pkgs.gui = {
      desktop.enable = mkDefault cfg.enable;
      dev.enable = mkDefault cfg.enable;
      internet.enable = mkDefault cfg.enable;
      communication.enable = mkDefault cfg.enable;
      media.enable = mkDefault cfg.enable;
      gaming.enable = mkDefault cfg.enable;
      productivity.enable = mkDefault cfg.enable;
      security.enable = mkDefault cfg.enable;
      specialized.enable = mkDefault cfg.enable;
      programs.enable = mkDefault cfg.enable;
    };
  };
}
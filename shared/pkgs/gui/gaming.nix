{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.shared.pkgs.gui.gaming;
in {
  options.shared.pkgs.gui.gaming = {
    enable = mkEnableOption "Gaming packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      prismlauncher   # Minecraft launcher
      steam-tui       # Terminal UI for Steam
      sssnake         # Terminal snake game
    ];

    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
      gamescope.enable = true;
    };
  };
}
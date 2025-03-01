{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.pkgs.gui.gaming;
in
{
  options.common.optional.pkgs.gui.gaming = {
    enable = mkEnableOption "Gaming packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      prismlauncher # Minecraft launcher
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

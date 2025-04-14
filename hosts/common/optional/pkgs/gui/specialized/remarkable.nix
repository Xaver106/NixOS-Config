{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.pkgs.gui.specialized.remarkable;
in
{

  options.common.optional.pkgs.gui.specialized.remarkable = {
    enable = mkEnableOption "ReMarkable Software";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      /*
        ReMarkable Software
        https://github.com/reHackable/awesome-reMarkable
      */
      rmview # Screenshare for the ReMarkable Tablet (NOTE: Needs UDP Port 5901 open)
      remarkable-mouse # A program to use a reMarkable as a graphics tablet
    ];

    networking.firewall.allowedUDPPorts = [
      5901 # Port needs to be open for rmview
    ];

  };
}

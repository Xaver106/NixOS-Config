{config, pkgs, lib, ...}:
with lib;

let
  cfg = config.shared.pkgs.gui.programs.rmview;
in {

  options.shared.pkgs.gui.programs.rmview = {
    enable = mkEnableOption "obs";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      /* ReMarkable Software
        https://github.com/reHackable/awesome-reMarkable
      */
      rmview # Screenshare for the ReMarkable Tablet (NOTE: Needs UDP Port 5901 open)
    ];

    networking.firewall.allowedUDPPorts = [ 
      5901 # Port needs to be open for rmview
    ];

  };
}

{config, pkgs, lib, ...}:
with lib;

let
  cfg = config.shared.pkgs.gui.programs.obs;
in {

  options.shared.pkgs.gui.programs.obs = {
    enable = mkEnableOption "obs";
  };
  
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
      })
    ];

    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
    security.polkit.enable = true;
  };
}

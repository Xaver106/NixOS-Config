{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.audio;
in
{

  options.common.optional.audio = {
    enable = mkEnableOption "audio";
  };

  config = mkIf cfg.enable {
    # Enable sound with pipewire.
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    environment.systemPackages = mkIf config.switches.gui [
      pkgs.helvum
    ];

  };
}

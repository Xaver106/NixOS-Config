{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.shared.audio;
in
{

  options.shared.audio = {
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
  };
}

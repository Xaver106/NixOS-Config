{config, pkgs, lib, ...}:
with lib;
let
  cfg = config.optional.pipewire;
in
{
  imports = [
    
  ];

  options.optional.pipewire = {
    enable = options.mkEnableOption "pipewire";
  };

  config = mkIf cfg.enable {
    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}

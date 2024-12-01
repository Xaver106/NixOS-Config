{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.shared.pkgs.gui.media;
in
{
  options.shared.pkgs.gui.media = {
    enable = mkEnableOption "Media packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Video
      mpv # Modern media player

      # Audio
      spotify # Music streaming
      goodvibes # Internet radio player
      audacity # Audio editor

      # Graphics/Images
      inkscape # Vector graphics editor
      gimp # Image editor
      qimgv # Image viewer
    ];
  };
}

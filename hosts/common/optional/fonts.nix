{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.fonts;
in
{

  options.common.optional.fonts = {
    enable = mkEnableOption "fonts";
  };

  config = mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = true; # Install some general default fonts
      packages = with pkgs; [
        # Nerdfonts
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
        nerd-fonts.iosevka
        nerd-fonts.iosevka-term
        nerd-fonts.hack

        # other random Fonts I neeed at some point
        font-awesome
        roboto
        source-sans
        source-sans-pro
      ];
    };
  };
}

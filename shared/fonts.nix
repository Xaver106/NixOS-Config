{config, pkgs, lib, ...}:
with lib;

let cfg = config.shared.fonts;
in {

  options.shared.fonts = {
    enable = mkEnableOption "fonts";
  };

  config = mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = true; # Install some general default fonts
      packages = with pkgs; [
        nerdfonts # All Nerdfonts 
      ];
    };
  };
}
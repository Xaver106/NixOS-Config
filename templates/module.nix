{config, pkgs, lib, ...}:
with lib;

let cfg = config.;
in {

  options. = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    
    environment.systemPackages = with pkgs; [
      
    ];

  };
}

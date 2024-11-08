{config, pkgs, lib, ...}:
with lib;

let cfg = shared.pkgs;
in {

  options.cfg = {
    enable = mkEnableOption "";
  };

  config = mkif cfg.enable {
    
    environment.systemPackages = with pkgs; [
      
    ];

  };
}

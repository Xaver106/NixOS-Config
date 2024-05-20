{config, pkgs, lib, ...}:
with lib;
let
  cfg = config.optional.printing;
in
{
  imports = [
    
  ];

  options.optional.printing = {
    enable = options.mkEnableOption "printing";
  };

  config = mkIf cfg.enable {
    # Enable printing services
    services.printing.enable = true; # Enable CUPS to print documents.
    services.avahi = { # Auto detect Network printers
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}

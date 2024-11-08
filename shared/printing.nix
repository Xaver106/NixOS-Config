{config, pkgs, lib, ...}:
with lib;

let cfg = config.shared.printing;
in {

  options.shared.printing = {
    enable = mkEnableOption "printing";
  };

  config = mkIf cfg.enable {
    services.printing.enable = true; # Enable CUPS to print documents.
    services.avahi = { # Auto detect Network printers
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}

{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.shared.specialisations.isolated;
in
{

  options.shared.specialisations.isolated = {
    enable = mkEnableOption "Isolated Specialisation";
  };

  config = mkIf cfg.enable {
    specialisation.isolated.configuration = {
      fileSystems."/tmpfs" = {
        device = "none";
        fsType = "tmpfs";
        options = [
          "size=3G"
          "mode=777"
          "noswap"
        ];
      };

      shared = {
        networking.enable = mkForce false;
        bluetooth.enable = mkForce false;
        printing.enable = mkForce false;
        pkgs = {
          latex.enable = mkForce false;
          gui = {
            gaming.enable = mkForce false;
            communication.enable = mkForce false;
          };
        };
      };

      networking = {
        useDHCP = mkForce false;
        interfaces = mkForce { };
        wireless.enable = mkForce false;
        networkmanager.enable = mkForce false;
      };
      systemd.network = {
        enable = mkForce false;
        netdevs = mkForce { };
      };
    };
  };
}

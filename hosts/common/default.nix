{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{

  imports = [
    ./global
    ./optional
  ];

  options = {
    setup = {
      workstationDefaults = mkEnableOption "Workstation Defaults";
    };
  };

  config = mkIf config.setup.workstationDefaults {

    virtualisation.docker.enable = mkDefault true;

    services = {
      flatpak.enable = mkDefault true; # Enables Flatpak
      teamviewer.enable = mkDefault true; # Remote Desktop
      mullvad-vpn = {
        enable = mkDefault true;
        package = mkDefault pkgs.mullvad-vpn;
      };
    };

    programs = {
      ausweisapp = {
        # Install German AusweisApp2 and open Firewall, so my phone can act ass a card reader
        enable = mkDefault true;
        openFirewall = mkDefault true;
      };
    };

    common.optional = {
      specialisations.enable = mkDefault false;
      pkgs = {
        calculators.enable = mkDefault true;
        dev.enable = mkDefault true;
        latex.enable = mkDefault false;
        security.enable = mkDefault true;
        gui = {
          communication.enable = mkDefault true;
          desktop.enable = mkDefault true;
          dev.enable = mkDefault true;
          gaming.enable = mkDefault true;
          internet.enable = mkDefault true;
          media.enable = mkDefault true;
          productivity.enable = mkDefault true;
          programs.enable = mkDefault true;
          security.enable = mkDefault true;
          system.enable = mkDefault true;
          dddprinting.enable = mkDefault true;
          remarkable.enable = mkDefault true;
        };
      };
      audio.enable = mkDefault true;
      bluetooth.enable = mkDefault true;
      fonts.enable = mkDefault true;
      networking.enable = mkDefault true;
      plasma.enable = mkDefault true;
      printing.enable = mkDefault true;
      virtualisation.enable = mkDefault true;
      yubikey.enable = mkDefault true;
      zsa.enable = mkDefault true;
    };

  };
}

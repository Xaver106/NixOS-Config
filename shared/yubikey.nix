{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.shared.yubikey;
in
{

  options.shared.yubikey = {
    enable = mkEnableOption "yubikey support";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      yubioath-flutter # Yubikey Authenticator DEPEND: pcscd
      gnome-screenshot # Scan QR code for Yubikey Authenticator
      yubikey-manager # Yubikey Manager CLI
      opensc # Set of libraries and utilities to access smart cards
    ];

    services.pcscd.enable = true; # Smartcard Deamon

    services.udev.packages = [
      pkgs.yubikey-manager
      pkgs.yubikey-personalization
    ];
  };
}

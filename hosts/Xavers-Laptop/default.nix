# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ../common
    inputs.nixos-hardware.nixosModules.framework-11th-gen-intel
    ./hardware-configuration.nix
  ];

  networking.hostName = "Xavers-Laptop";
  setup.workstationDefaults = true;

  boot.initrd.systemd.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable firmware updates
  services.fwupd.enable = true;

  security.pam.services.login.fprintAuth = false; # Disable fingerprint login (Kwallet doesn't unlock with it)

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1h
  '';

  common.optional = {
    specialisations.enable = true;
    pkgs.gui.gaming.enable = false;
  };

}

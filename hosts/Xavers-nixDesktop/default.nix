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
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  networking.hostName = "Xavers-nixDesktop";

  boot.initrd.systemd.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.hardwareClockInLocalTime = true; # Fix windows showing wrong time

  programs.streamcontroller.enable = true;

  services.boinc.enable = true; # BOINC Client and Manager (Distributet computing service)

}

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
    ./secure-boot.nix
  ];

  networking.hostName = "Xavers-nixDesktop";
  setup.workstationDefaults = true;

  # Bootloader.
  boot = {
    initrd.systemd.enable = true;
    loader = {
      systemd-boot = {
        enable = true; # NOTE: Overidden by secure-boot.nix (Kept as backup) 
        edk2-uefi-shell.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  programs.streamcontroller.enable = true;

}

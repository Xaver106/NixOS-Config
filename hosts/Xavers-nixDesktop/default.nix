# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [
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

  environment.systemPackages = with pkgs; [
    deckmaster # Elgato Stream Deck software
  ];

  services.udev.packages = [ (pkgs.writeTextDir "etc/udev/rules.d/99-streamdeck.rules"
    ''
      SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="0060", MODE:="666", GROUP="plugdev", SYMLINK+="streamdeck"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="006d", MODE:="666", GROUP="plugdev", SYMLINK+="streamdeck"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="0080", MODE:="666", GROUP="plugdev", SYMLINK+="streamdeck"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="0063", MODE:="666", GROUP="plugdev", SYMLINK+="streamdeck-mini"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="006c", MODE:="666", GROUP="plugdev", SYMLINK+="streamdeck-xl"
    ''
    ) ];

  services.boinc.enable = true; # BOINC Client and Manager (Distributet computing service)

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

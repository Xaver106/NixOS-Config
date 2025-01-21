{
  inputs,
  outputs,
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib;
{

  imports = [
    ./AI.nix
    ./audio.nix
    ./bluetooth.nix
    ./fonts.nix
    ./networking.nix
    ./plasma.nix
    ./printing.nix
    ./yubikey.nix
    ./zsa.nix

    ./pkgs
    ./specialisations
  ];

  common.optional = with lib; {
    specialisations.enable = mkDefault true;
    pkgs.enable = mkDefault true;

    ai.enable = mkDefault false;
    audio.enable = mkDefault true;
    bluetooth.enable = mkDefault true;
    fonts.enable = mkDefault true;
    networking.enable = mkDefault true;
    plasma.enable = mkDefault true;
    printing.enable = mkDefault true;
    yubikey.enable = mkDefault true;
    zsa.enable = mkDefault true;
  };

  programs = {
    kdeconnect.enable = mkDefault true; # KDE Connect
    ausweisapp = {
      # Install German AusweisApp2 and open Firewall, so my phone can act ass a card reader
      enable = mkDefault true;
      openFirewall = mkDefault true;
    };
    /*
      Android Debug Bridge
      wiki: https://nixos.wiki/wiki/Android
    */
    adb.enable = mkDefault true;
  };

  services = {
    flatpak.enable = mkDefault true; # Enables Flatpak
    teamviewer.enable = mkDefault true; # Remote Desktop
    mullvad-vpn = {
      enable = mkDefault true;
      package = mkDefault pkgs.mullvad-vpn;
    };
  };

}
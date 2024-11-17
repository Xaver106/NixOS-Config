# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, outputs, lib, config, options, pkgs, ... }:

{

  imports =
    [
      inputs.catppuccin.nixosModules.catppuccin
      ./audio.nix
      ./bluetooth.nix
      ./documentation.nix
      ./fonts.nix
      ./locale-defaults.nix
      ./networking.nix
      ./plasma.nix
      ./printing.nix
      ./yubikey.nix
      ./zsa.nix
      ./pkgs
      ./specialisations
    ];

  shared = with lib; {
    locale-defaults.enable = mkDefault true;
    networking.enable = mkDefault true;
    plasma.enable = mkDefault true;
    printing.enable = mkDefault true;
    yubikey.enable = mkDefault true;
    zsa.enable = mkDefault true;
    audio.enable = mkDefault true;
    bluetooth.enable = mkDefault true;
    documentation.enable = mkDefault true;
    fonts.enable = mkDefault true;
    pkgs.enable = mkDefault true;
    specialisations.enable = mkDefault true;
  };


  
  nixpkgs.config.allowUnfree = true; # Allow unfree packages
  nixpkgs.overlays = [
    outputs.overlays.master-packages
    outputs.overlays.stable-packages
  ];

  console.catppuccin.enable = true;

  users.defaultUserShell = pkgs.fish; # Set default shell to fish


  programs = {
    fish.enable = true; # Fish Shell
    kdeconnect.enable = true; # KDE Connect
    ausweisapp = {
      # Install German AusweisApp2 and open Firewall, so my phone can act ass a card reader
      enable = true;
      openFirewall = true;
    };
    ssh.startAgent = true; # Start SSH Agent on login

    /*
    Android Debug Bridge 
    wiki: https://nixos.wiki/wiki/Android
    */
    adb.enable = true;
  };

  services = {
    flatpak.enable = true; # Enables Flatpak
    teamviewer.enable = true; # Remote Desktop
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };




  nix = {
    gc = { # Enable Garbage Collection
      automatic = true;
      dates = "daily"; # Fire daily
      options = "--delete-older-than 7d"; # Delete Generations older than 7 days
    };
    settings = {
      auto-optimise-store = true; # Try to reduce size of nix Store
      experimental-features = [ "nix-command" "flakes" ]; # Enable Flakes and the nix Command
    };
    #Add the system flake locatet at /etc/nixos to the registry as "system"
    registry."system" = {
      from = {
        id = "system";
        type = "indirect";
      }; 
      to = {
        path = "/etc/nixos/";
        type = "path";
      };
    };

  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

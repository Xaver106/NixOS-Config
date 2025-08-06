{
  inputs,
  outputs,
  lib,
  config,
  options,
  pkgs,
  ...
}:
{

  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    ./documentation.nix
    ./locale-defaults.nix
    ./sops.nix
    ./pkgs.nix
  ];

  nixpkgs.config.allowUnfree = true; # Allow unfree packages
  nixpkgs.overlays = [
    outputs.overlays.master-packages
    outputs.overlays.stable-packages
  ];

  # Enable firmware updates
  services.fwupd.enable = true;

  catppuccin.tty.enable = true;

  users.defaultUserShell = pkgs.fish; # Set default shell to fish

  programs = {
    fish.enable = true; # Fish Shell
    ssh.startAgent = true; # Start SSH Agent on login
  };

  nix = {
    gc = {
      # Enable Garbage Collection
      automatic = true;
      dates = "daily"; # Fire daily
      options = "--delete-older-than 7d"; # Delete Generations older than 7 days
    };
    settings = {
      auto-optimise-store = true; # Try to reduce size of nix Store
      experimental-features = [
        "nix-command"
        "flakes"
      ]; # Enable Flakes and the nix Command
      trusted-users = [ "@wheel" ];
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
  system.stateVersion = "24.11"; # Did you read the comment?

}

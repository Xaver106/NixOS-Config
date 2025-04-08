{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{

  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # Define my user account.
  users.users.xaver106 = {
    isNormalUser = true;
    description = "Xaver106";
    extraGroups = [
      "adbusers"
      "boinc"
      "docker"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "wheel"
    ];
    /*
      adbusers: Allow user to use adb (android debug bridge)
      boinc: Allow user to use boinc/connect to client
      docker: Allows usage of Docker NOTE: This is basically root perissions. Cosider using rootless docker
      libvirtd: Virtualisation Authentication access
      networkmanager: Allow user to use networkmanager to manage network connections
      plugdev: Gives access to mount sme devices NOTE: Needed to interact with YubiKeys
      wheel: Allow user to use sudo
    */
  };

  # Certain features, including CLI integration and system authentication support,
  # require enabling PolKit integration on some desktop environments (e.g. Plasma).
  programs._1password-gui.polkitPolicyOwners = [ "xaver106" ];

  home-manager.users.xaver106 = {
    home = {
      username = "xaver106";
      homeDirectory = "/home/xaver106";
    };

    imports = [
      ./home
      inputs.catppuccin.homeModules.catppuccin
    ];
  };
}

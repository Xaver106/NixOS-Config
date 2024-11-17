{pkgs, lib, config, inputs, ...}:
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
    extraGroups = [ "networkmanager" "wheel" "adbusers" "boinc" "plugdev"];
    /*
    networkmanager: Allow user to use networkmanager to manage network connections
    wheel: Allow user to use sudo
    adbusers: Allow user to use adb (android debug bridge) (enabled with programs.adb.enable)
    boinc: Allow user to use boinc/connect to client (enabled with services.boinc.enable)
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
      inputs.catppuccin.homeManagerModules.catppuccin
    ];
  };
}

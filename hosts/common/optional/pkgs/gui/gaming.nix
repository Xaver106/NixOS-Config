{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.pkgs.gui.gaming;
in
{
  options.common.optional.pkgs.gui.gaming = {
    enable = mkEnableOption "Gaming packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (prismlauncher.override {
        # Change Java runtimes available to Prism Launcher
        jdks = with pkgs; [
          temurin-jre-bin
          temurin-jre-bin-17
        ];
      })

      mangohud # Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more
      protonplus # Simple Wine and Proton-based compatibility tools manager

      gpu-screen-recorder
      gpu-screen-recorder-gtk

    ];

    # XBOX Controller support
    hardware.xone.enable = true;
    hardware.firmware = with pkgs; [
      xow_dongle-firmware
    ];

    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
      };
      gamescope = {
        enable = true;
        capSysNice = true;
      };
      gamemode.enable = true;
      gpu-screen-recorder.enable = true;
    };
  };
}

{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.shared.pkgs.gui.communication;
in {
  options.shared.pkgs.gui.communication = {
    enable = mkEnableOption "Communication packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Messaging & Chat
      signal-desktop     # Secure messenger
      teamspeak_client   # Voice chat
      element-desktop    # Matrix client

      # Discord
      (pkgs.master.discord.override {
        withVencord = true;  # Discord with Vencord mod
      })
      vesktop            # Alternative Discord client

      # Email
      thunderbird        # Email client
    ];
  };
}

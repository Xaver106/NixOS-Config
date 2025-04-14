{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.pkgs.gui.communication;
in
{
  options.common.optional.pkgs.gui.communication = {
    enable = mkEnableOption "Communication packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Messaging & Chat
      signal-desktop # Secure messenger
      teamspeak_client # Voice chat
      element-desktop # Matrix client
      zapzap # WhatsApp client

      # Discord
      (pkgs.master.discord.override {
        withVencord = true; # Discord with Vencord mod
      })
      vesktop # Alternative Discord client

      # Email
      thunderbird # Email client
    ];

    # Noise Supression
    programs.noisetorch.enable = true;
  };
}

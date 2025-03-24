{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.networking;
in
{

  imports = [
    ../../../modules/dnscrypt.nix # DNSCrypt Module
  ];

  options.common.optional.networking = {
    enable = mkEnableOption "networking";
  };

  config = mkIf cfg.enable {

    # Enable Networking and configure
    networking.networkmanager.enable = true;
    # Enable and configure my own DNSCrypt Module
    dnscrypt-module = {
      enable = true;
      serverNames = [
        "cloudflare-security-ipv6"
        "cloudflare-security"
      ];
      forwardingRules = [
        {
          domain = "local";
          servers = [ "192.168.10.1" ];
        }
        {
          domain = "fritz.box";
          servers = [ "192.168.10.1" ];
        }
        {
          domain = "login.wifionice.de";
          servers = [ "172.18.0.1" ];
        }
        {
          domain = "iceportal.de";
          servers = [ "172.18.0.1" ];
        }
      ];
    };
  };
}

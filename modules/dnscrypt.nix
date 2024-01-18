# This NixOS module configuration for dnscrypt-proxy2 is inspired by the examples
# found in the NixOS wiki. For more details, see: https://nixos.wiki/wiki/Encrypted_DNS

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.dnscrypt-module;
in
{
  options.dnscrypt-module = {
    enable = mkEnableOption "dnscrypt-proxy2";

    serverNames = mkOption {
      type = types.listOf types.str;
      default = [ "cloudflare" "cloudflare-ipv6" ];
      description = "List of dnscrypt-proxy server names to use.";
    };
  };

  config = mkIf cfg.enable {

    networking = {
      nameservers = [ "127.0.0.1" "::1" ]; # Point the system to dnscrypt-proxy2
      dhcpcd.extraConfig = "nohook resolv.conf"; # If using dhcpcd
      networkmanager.dns = "none"; # If using NetworkManager
    };

    services.dnscrypt-proxy2 = {
      enable = true;
      settings = {
        ipv6_servers = true;
        require_dnssec = true;

        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };

        server_names = cfg.serverNames;
      };
    };

    systemd.services.dnscrypt-proxy2.serviceConfig = {
      StateDirectory = "dnscrypt-proxy";
    };
  };
}

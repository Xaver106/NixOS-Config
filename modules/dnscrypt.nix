# This NixOS module configuration for dnscrypt-proxy2 is inspired by the examples
# found in the NixOS wiki. For more details, see: https://nixos.wiki/wiki/Encrypted_DNS
# Parts are inspired by https://github.com/Shados/nix-config-shared/blob/771dd8373ede39ddca0008f3b0b7d50e97b4bf7f/nixos/bespoke/services/dnscrypt2.nix#L908

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.dnscrypt-module;

  forwardingRule = types.submodule {
    options = {
      domain = mkOption {
        type = types.str;
        description = "The domain to forward queries for.";
        example = "local";
      };
      servers = mkOption {
        type = with types; listOf str;
        description = "The servers to forward queries for the matched domain to.";
        example = [ "192.168.178.1" ];
      };
    };
  };
in
{
  options.dnscrypt-module = {
    enable = mkEnableOption "dnscrypt-proxy2";

    serverNames = mkOption {
      type = types.listOf types.str;
      default = [ "cloudflare" "cloudflare-ipv6" ];
      description = "List of dnscrypt-proxy server names to use. See https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md for all available.";
    };

    forwardingRules = mkOption {
        type = with types; listOf forwardingRule;
        default = [];
        description = "Routes queries for specific domains to dedicated sets of servers.";
        example = [
          { domain = "local"; servers = [ "192.168.178.1" ]; }
          { domain = "fritz.box"; servers = [ "192.168.178.1" ]; }
        ];
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
      settings = let
        forwardingRuleFile = pkgs.writeText "forwarding-rules.txt" (concatMapStringsSep "\n" (fr:
          "${fr.domain} ${concatStringsSep "," fr.servers}"
        ) cfg.forwardingRules);
      in
      {
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

        forwarding_rules = forwardingRuleFile; # Thanks to Shados for this elegant solution

        server_names = cfg.serverNames;
      };
    };

    systemd.services.dnscrypt-proxy2.serviceConfig = {
      StateDirectory = "dnscrypt-proxy";
    };
  };
}

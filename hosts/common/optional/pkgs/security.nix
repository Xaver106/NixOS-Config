{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.pkgs.security;
in
{
  options.common.optional.pkgs.security = {
    enable = mkEnableOption "Security packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Encryption Tools
      veracrypt # Disk encryption

      # Certificate Management
      gnupg # GNU Privacy Guard
      gpgme # GnuPG Made Easy
      gpg-tui # Terminal UI for GnuPG

      # Age Encryption
      age # Modern encryption tool with small explicit keys
      age-plugin-yubikey # YubiKey plugin for age

      # Password Generators
      xkcdpass # Generate secure multiword passwords/passphrases, inspired by XKCD
      genpass # Simple yet robust commandline random password generator
    ];

    programs = {
      gnupg.agent.enable = true;
      _1password.enable = true; # 1Password CLI
    };

  };
}

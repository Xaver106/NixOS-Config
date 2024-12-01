{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.shared.pkgs.base;
in
{
  options.shared.pkgs.base = {
    enable = mkEnableOption "Base packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # File Operations
      bat # Better cat
      eza # Better ls
      fd # Better find
      ripgrep # Better grep
      unzip # Archive extraction

      # File Managers
      ranger # Vim-like file manager

      # Text Editors
      helix # Modern modal editor

      # Version Control
      git # Version control system

      # Shell Utilities
      chezmoi # Dotfile manager
      killall # Process killer
      thefuck # Command correction
      fzf # Fuzzy finder
      pandoc # Document converter

      # Terminal Multiplexers
      tmux # Terminal multiplexer
      zellij # Modern terminal multiplexer

      # System Monitoring
      btop # Resource monitor
      dust # Disk usage analyzer

      # Hardware Info
      lshw # List hardware
      inxi # System information
      pciutils # PCI utilities
      fastfetch # System information display

      # File System
      fdupes # Find duplicate files
      ntfs3g # NTFS support

      # Network Tools
      wget # File download
      dig # DNS lookup
      speedtest-cli # Internet speed test
    ];
  };
}

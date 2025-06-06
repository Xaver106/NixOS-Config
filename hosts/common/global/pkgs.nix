{
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # File Operations
    bat # Better cat
    eza # Better ls
    fd # Better find
    ripgrep # Better grep
    unzip # Archive extraction

    # File Managers
    ranger # Vim-like file manager
    lf # Terminal file manager written in Go and heavily inspired by ranger

    # Text Editors
    helix # Modern modal editor

    # Task Runners
    go-task # Task runner

    # Version Control
    git # Version control system
    lazygit # Terminal UI for git
    difftastic # Syntax-aware diff

    # Shell Utilities
    killall # Process killer
    fzf # Fuzzy finder
    pandoc # Document converter

    # Terminal Multiplexers
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
    exfat # EXFAT Support
    exfatprogs

    # Network Tools
    wget # File download
    dig # DNS lookup
    cfspeedtest # Internet speed test
  ];
}

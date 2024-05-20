# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, options, pkgs, ... }:

{

  imports =
    [
      "../modules/dnscrypt.nix" # DNSCrypt Module
    ];


  nixpkgs.config.allowUnfree = true; # Allow unfree packages

  services.xserver.enable = true; # Enable the X11 windowing system.

  # Enable and configure SDDM display manager
  services.displayManager = {
    sddm = {
      enable = true;
      theme = "breeze"; # set login theme
      autoNumlock = true; # enable numLock on login
      settings = {
        Theme.CursorTheme = "breeze_cursors"; # set cursor theme
      };
    };
  };

  services.xserver.desktopManager.plasma5.enable = false; # Enable KDE Plasma 5
  services.desktopManager.plasma6.enable = true; # Enable KDE Plasma 6

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
  users.defaultUserShell = pkgs.fish; # Set default shell to fish


  # Installed packages
  environment.systemPackages = with pkgs; [

    # Unsorted
    gparted # Partition Manager
    filezilla # FTP Client
    cryptomator # Encryption Tool
    prusa-slicer # 3D Printer Slicer
    nextcloud-client # Nextcloud Client
    firefox # Web Browser
    spotify # Music Streaming
    thunderbird # E-Mail Client
    rpi-imager # Raspberry Pi Imager
    qalculate-qt # calculator
    # bottles # Wine Wrapper
    # wineWowPackages.full 
    # winetricks
    # samba4Full
    tdb
    mpv # Video Player
    wget # Download Manager
    goodvibes # Internet Radio Player
    kitty # Terminal Emulator
    anki-bin # Flashcard App (see Wiki https://nixos.wiki/wiki/Anki)
    josm # OpenStreetMap Editor
    libsForQt5.filelight # Disk Usage Analyzer
    tor-browser # Tor Browser
    ntfs3g # NTFS Support
    zettlr # Note Taking App
    logseq # Note Taking App
    unzip
    ungoogled-chromium
    desktop-file-utils # Desktop File Utilities
    localsend # Air-Drop alternative
    telegram-desktop # Telegram Messenger
    sssnake
    steam-tui
    nix-tree
    ventoy-full
    colobot # Game
    qimgv # Photo Editor

    /*
    Matrix Clients
    https://nixos.wiki/wiki/Matrix
    */
    element-desktop

    # Git + Tools
    gitFull # Git
    # smartgithg # Git GUI
    gittyup
    lazygit # Git TUI

    # Build Tools
    maven # Build Tool for Java
    gradle # Build Tool for Java

    # Image Editing
    inkscape # Vector Graphics Editor
    gimp # Image Editor
    
    # Authentication
    yubioath-flutter # Yubikey Authenticator
    yubikey-manager-qt # Yubikey Manager GUI
    yubikey-personalization # Yubikey Personalization CLI
    yubikey-personalization-gui # Yubikey Personalization GUI

    # IDEs + Text Editors
    vscode # Visual Studio Code
    jetbrains-toolbox # Jetbrains IDEs
    kate # Text Editor

    # Latex
    texlive.combined.scheme-full # Latex
    tectonic # Modern Latex Compiler
    jabref # Reference Manager

    # LibreOffice + Spell Checking
    libreoffice-qt # Office Suite
    hunspell # Spell Checking
    hunspellDicts.de_DE # Spell Checking German
    hunspellDicts.en_US # Spell Checking English

    # Minecraft
    prismlauncher # Minecraft Launcher

    # Communication
    signal-desktop # Signal Messenger
    threema-desktop # Threema Messenger
    teamspeak_client # Teamspeak
    (pkgs.discord.override {withVencord = true;}) # Discord + Vencord
    vesktop

    # Coding Languages + Compilers
    # Java Installed trough programs.java
    python3 # Python
    gcc # C Compiler
    go # Go
    lua # Lua
    clang-tools # C/C++ Tools
    swiProlog # Prolog
    cargo # Rust Compiler
    rustup # Rust Toolchain installer
    typst # Typst Language framework

    # Language Servers
    lua-language-server # Lua Language Server
    texlab # Latex Language Server
    nil # Nix Language Server
    python311Packages.python-lsp-server # Python Language Server
    jdt-language-server # Java Language Server
    gopls # Go Language Server
    nodePackages_latest.vscode-json-languageserver # JSON + JSONC Language Server
    marksman # Markdown Language Server
    rust-analyzer # Rust Language Server
    haskell-language-server # Haskell Language Server
    typst-lsp # Language Server for the Typst language

    # Formatters
    bibtex-tidy # Latex Formatter

    # Debuggers
    lldb # VSCode Debugger API
    delve # Go Debugger

    # Command Line Tools and TUIs
    chezmoi # Dotfile Manager 
    dust # Disk Usage Statistics
    btop # Resource Monitor
    bat # Cat Clone
    eza # File listing
    thefuck # Correct Command mistakes
    mc # File manager TUI
    dig # DNS Lookup
    gpg-tui # GPG TUI
    ranger # Console File Manager
    fzf # Search tool
    tmux # Terminal Multiplexer
    zellij # Terminal Multiplexer
    speedtest-cli
    helix # Text Editor
    fastfetch # Fast neofetch implementation
    pandoc

    # Neovim + Lazy.vim Requirements
    neovim
    fd
    ripgrep

    # Man Pages + tldr
    man-pages # man pages for Linux
    man-pages-posix # man pages for POSIX
    tldr # Short explanations for commands
  ];


  programs = {
    fish.enable = true; # Fish Shell
    kdeconnect.enable = true; # KDE Connect
    _1password.enable = true; # 1Password CLI
    _1password-gui = {
      enable = true;
      # Certain features, including CLI integration and system authentication support,
      # require enabling PolKit integration on some desktop environments (e.g. Plasma).
      polkitPolicyOwners = [ "xaver106" ];
    };
    ausweisapp = {
      # Install German AusweisApp2 and open Firewall, so my phone can act ass a card reader
      enable = true;
      openFirewall = true;
    };
    java = {
      enable = true;
    };

    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    gamescope.enable = true;

    ssh.startAgent = true; # Start SSH Agent on login
    dconf.enable = true; # orrect KDE Theme on Wayland
    gnupg.agent = {
      # Enable GPG and set pinentry
      enable = true;
    };
    /*
    Android Debug Bridge 
    wiki: https://nixos.wiki/wiki/Android
    */
    adb.enable = true;
    # Noise Supression
    noisetorch.enable = true;
  };

  services = {
    flatpak.enable = true; # Enables Flatpak
    pcscd.enable = true; # Needed for yubico authenticator (Smart Card Reader)
    teamviewer.enable = true; # Remote Desktop
  };
  


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

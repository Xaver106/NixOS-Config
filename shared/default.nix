# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, options, pkgs, ... }:

{

  imports =
    [
      ../modules/dnscrypt.nix # DNSCrypt Module
    ];

  # Select internationalisation properties.
  time.timeZone = "Europe/Berlin"; # Set timezone to Berlin
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  nixpkgs.config.allowUnfree = true; # Allow unfree packages

  # Enable Networking and configure
  networking.networkmanager.enable = true; 
  # Enable and configure my own DNSCrypt Module
  dnscrypt-module = {
    enable = true;
    serverNames = [ "cloudflare-security" "cloudflare-security-ipv6" ];
    forwardingRules = [
      { domain = "local"; servers = [ "192.168.10.1" ]; }
      { domain = "fritz.box"; servers = [ "192.168.10.1" ]; }
      { domain = "login.wifionice.de"; servers = [ "172.18.0.1" ]; }
      { domain = "iceportal.de"; servers = [ "172.18.0.1" ]; }
    ];
  };

  # Enable Bluetoth, obviously...
  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };
  console.keyMap = "de"; # Configure console keymap

  # Enable printing services
  services.printing.enable = true; # Enable CUPS to print documents.
  services.avahi = { # Auto detect Network printers
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment = {
    # Set the default text editor
    variables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };
  };


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

  fonts = {
    enableDefaultPackages = true; # Install some general default fonts
    packages = with pkgs; [
      nerdfonts # All Nerdfonts 
    ];
  };

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
    bottles # Wine Wrapper
    wineWowPackages.full 
    winetricks
    samba4Full
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
    freecad # CAD Software
    zettlr # Note Taking App
    logseq # Note Taking App
    unzip
    keymapp
    ungoogled-chromium
    desktop-file-utils # Desktop File Utilities
    localsend # Air-Drop alternative
    telegram-desktop # Telegram Messenger
    sssnake
    steam-tui

    /*
    Matrix Clients
    https://nixos.wiki/wiki/Matrix
    */
    element-desktop

    # Git + Tools
    gitFull # Git
    smartgithg # Git GUI
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

    steam.enable = true;

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
  
  services.udev.packages = [ (pkgs.writeTextDir "etc/udev/rules.d/50-zsa.rules"
    ''
    # Rules for Oryx web flashing and live training
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

    # Legacy rules for live training over webusb (Not needed for firmware v21+)
      # Rule for all ZSA keyboards
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
      # Rule for the Moonlander
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
      # Rule for the Ergodox EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
      # Rule for the Planck EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

    # Wally Flashing rules for the Ergodox EZ
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
    KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

    # Keymapp / Wally Flashing rules for the Moonlander and Planck EZ
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
    # Keymapp Flashing rules for the Voyager
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"
    ''
    ) ];

  nix = {
    gc = { # Enable Garbage Collection
      automatic = true;
      dates = "daily"; # Fire daily
      options = "--delete-older-than 7d"; # Delete Generations older than 7 days
    };
    settings = {
      auto-optimise-store = true; # Try to reduce size of nix Store
      experimental-features = [ "nix-command" "flakes" ]; # Enable Flakes and the nix Command
    };
    #Add the system flake locatet at /etc/nixos to the registry as "system"
    registry."system" = {
      from = {
        id = "system";
        type = "indirect";
      }; 
      to = {
        path = "/etc/nixos/";
        type = "path";
      };
    };

  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

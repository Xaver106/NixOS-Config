# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, options, pkgs, modulesPath, nixpkgs-stable, ... }:

{
  time.timeZone = "Europe/Berlin"; # Set timezone to Berlin

  # Select internationalisation properties.
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

  networking.networkmanager.enable = true; # Enable Networking

  services.xserver.enable = true; # Enable the X11 windowing system.

  # Enable SDDM display manager
  services.xserver.displayManager = {
    sddm = {
      enable = true;
      theme = "breeze"; # set login theme
      autoNumlock = true; # enable numLock on login
      settings = {
        Theme.CursorTheme = "breeze_cursors"; # set cursor theme
      };
    };
  };

  services.xserver.desktopManager.plasma5.enable = true; # Enable KDE Plasma

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };
  console.keyMap = "de"; # Configure console keymap
  services.printing.enable = true; # Enable CUPS to print documents.

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

  # Define my user account.
  users.users.xaver106 = {
    isNormalUser = true;
    description = "Xaver106";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with nixpkgs-stable; [
      
    ];
  };

  # Installed packages
  environment.systemPackages = with pkgs; [

    # Unsorted
    ansible # a suite of software tools that enables infrastructure as code
    glances # system monitoring tool for Console
    ranger # Console File Manager
    gparted # Partition Manager
    neofetch # System Information Tool
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
    mpv # Video Player
    gpg-tui # GPG TUI
    nerdfonts # Nerd Fonts
    
    # Image Editing
    inkscape # Vector Graphics Editor
    gimp # Image Editor
    
    # Authentication
    yubioath-flutter # Yubikey Authenticator
    yubikey-manager-qt # Yubikey Manager GUI
    yubikey-personalization # Yubikey Personalization CLI
    yubikey-personalization-gui # Yubikey Personalization GUI

    # Git + Tools
    git # Git
    smartgithg # Git GUI
    lazygit # Git TUI

    # Build Tools
    maven # Build Tool for Java
    gradle # Build Tool for Java

    # IDEs + Text Editors
    vscode # Visual Studio Code
    jetbrains-toolbox # Jetbrains IDEs
    kate # Text Editor

    # Latex
    texlive.combined.scheme-full # Latex
    jabref # Reference Manager

    # Man Pages + tldr
    man-pages # man pages for Linux
    man-pages-posix # man pages for POSIX
    tldr # Short explanations for commands

    # LibreOffice + Spell Checking
    libreoffice-qt # Office Suite
    hunspell # Spell Checking
    hunspellDicts.de_DE # Spell Checking German
    hunspellDicts.en_US # Spell Checking English

    # Minecraft
    prismlauncher-qt5 # Minecraft Launcher

    # Communication
    signal-desktop # Signal Messenger
    threema-desktop # Threema Messenger
    teamspeak_client # Teamspeak
    (pkgs.discord.override {withVencord = true;}) # Discord + Vencord
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
      package = pkgs.jdk17; # Java Version 17
    };

    ssh.startAgent = true; # Start SSH Agent on login
    dconf.enable = true; # orrect KDE Theme on Wayland
    gnupg.agent = {
      # Enable GPG and set pinentry
      enable = true;
      pinentryFlavor = "qt";
    };
  };

  services = {
    flatpak.enable = true; # Enables Flatpak
    pcscd.enable = true; # Needed for yubico authenticator
  };

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
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

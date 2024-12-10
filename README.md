# NixOS Configuration

This repository contains my personal NixOS system configuration files.

## ⚠️ Important Note

This configuration is published for educational and reference purposes only. While you're welcome to explore and learn from it, please note that:

- This is my personal setup, tailored to my specific needs and preferences
- Copying configurations without understanding them can lead to system issues
- You should build your own configuration based on your requirements

## Structure

The configuration is organized into these main directories:

- `shared/`: Core configuration components
  - `default.nix`: Main entry point with modular configuration options
  - Each component can be individually enabled/disabled
- `hosts/`: Host-specific configurations and shared config options
- `users/`: User environments and Home-manager configurations
- `scripts/`: Management Scripts
- `Taskfile.yml`: Taskfile for easier building

## Features

- Modular system configuration using NixOS Flakes
- Per-host configuration management
- Customizable shared components
- Home-manager integration for user environments
- GO-Task automation for common operations

## Resources

### Essential
- [Nixos & Flakes Book](https://nixos-and-flakes.thiscute.world/) - Recommended starting point for beginners
- [Package & Options Search](https://search.nixos.org) - Find available packages and options

### Documentation
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Nix Package Manager Guide](https://nixos.org/manual/nix/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)

## License

Copyright © 2023-2024 Xaver106

This work is published for educational purposes only. All rights reserved.

Feel free to use this as a reference, but remember to adapt any configurations to your own needs.

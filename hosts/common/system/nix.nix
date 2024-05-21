{config, pkgs, lib, ...}:
{
  imports = [
    
  ];

  options = {
    
  };

  config = {

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
    
  };
}

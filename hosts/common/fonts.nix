{config, pkgs, lib, ...}:
{
  imports = [
    
  ];

  options = {
    
  };

  config = {
    fonts = {
      enableDefaultPackages = true; # Install some general default fonts
      packages = with pkgs; [
        nerdfonts # All Nerdfonts 
      ];
    };
  };
}

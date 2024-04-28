{ config, pkgs, ... }:

{
  home.username = "xaver106";
  home.homeDirectory = "/home/xaver106";

  programs.fish.enable = true;

  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
      };
    };
  };

  programs.zoxide.enable = true;

  programs.git = {
    enable = true;
    userName = "Xaver106";
    userEmail = "xaver10610@gmail.com";
    signing.key = "B1A415AB920AFDA2";
    signing.signByDefault = true;
  };

  programs.eza = {
    enable = true;
    icons = true;
    extraOptions = [ "--group-directories-first" ];
  };
  
  programs.ranger = {
    enable = true;
    plugins = [
      {
        name = "ranger_devicons";
        src = builtins.fetchGit {
          url = "https://github.com/alexanderjeurissen/ranger_devicons.git";
          rev = "a8d626485ca83719e1d8d5e32289cd96a097c861";
        };
      }
      {
        name = "zoxide";
        src = builtins.fetchGit {
          url = "https://github.com/jchook/ranger-zoxide.git";
          rev = "281828de060299f73fe0b02fcabf4f2f2bd78ab3";
        };
      }
    ];
    settings = {
      preview_images = "true";
      preview_images_method = "kitty";
    };
    extraConfig = ''
      default_linemode devicons
    '';
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

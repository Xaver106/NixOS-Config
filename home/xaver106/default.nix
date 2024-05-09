{ config, pkgs, ... }:

{
  home.username = "xaver106";
  home.homeDirectory = "/home/xaver106";


  # === Kitty ===
  
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    font.name = "IosevkaTerm Nerd Font";
    settings = {
      confirm_os_window_close = 0;
    };
  };


  # === Fish Shell ===
  
  programs.fish = {
    enable = true;
    shellInit = ''
      fish_config theme choose "Catppuccin Mocha"
    '';
  };

  xdg.configFile."fish/themes/Catppuccin Mocha.theme".source = let
    catppuccin-fish = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "fish";
      rev = "0ce27b518e8ead555dec34dd8be3df5bd75cff8e";
      hash = "sha256-Dc/zdxfzAUM5NX8PxzfljRbYvO9f9syuLO8yBr+R3qg=";
    };
  in
    "${catppuccin-fish}/themes/Catppuccin Mocha.theme";


  # === Helix Editor ===
  
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


  # === Zoxide ===
  
  programs.zoxide.enable = true;


  # === Zellij ===
  
  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
    };
  };

  xdg.configFile."zellij/layouts" = {
    source = ./resources/Zellij-Layouts;
    recursive = true;
  };

  # === Lazygit ===

  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        theme = {
          activeBorderColor = [ "#89b4fa" "bold" ];
          inactiveBorderColor = [ "#a6adc8" ];
          optionsTextColor = [ "#89b4fa" ];
          selectedLineBgColor = [ "#313244" ];
          cherryPickedCommitBgColor = [ "#45475a" ];
          cherryPickedCommitFgColor = [ "#89b4fa" ];
          unstagedChangesColor = [ "#f38ba8" ];
          defaultFgColor = [ "#cdd6f4" ];
          searchingActiveBorderColor = [ "#f9e2af" ];
        };
        authorColors = {
          "*" = "#b4befe";
        };
      };
    };
  };


  # === Git ===

  programs.git = {
    enable = true;
    userName = "Xaver106";
    userEmail = "xaver10610@gmail.com";
    signing.key = "B1A415AB920AFDA2";
    signing.signByDefault = true;
  };


  # === EZA ===

  programs.eza = {
    enable = true;
    icons = true;
    extraOptions = [ "--group-directories-first" ];
  };


  # === Ranger ===
  
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


  # === Btop ===
  
  xdg.configFile."btop/themes/catppuccin_mocha.theme".source = let
    catppuccin-btop = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "btop";
      rev = "c6469190f2ecf25f017d6120bf4e050e6b1d17af";
      hash = "sha256-jodJl4f2T9ViNqsY9fk8IV62CrpC5hy7WK3aRpu70Cs=";
    };
  in
    "${catppuccin-btop}/themes/catppuccin_mocha.theme";

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

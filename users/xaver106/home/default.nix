{ config, pkgs, ... }:

{
  # === General ===

  home.shellAliases = {
    "nixedit" = "zellij -l nix";
  };

  catppuccin = {
    enable = true;
  };

  programs.ssh.forwardAgent = true;

  # === Kitty ===

  programs.kitty = {
    enable = true;
    font.name = "IosevkaTerm Nerd Font";
    settings = {
      confirm_os_window_close = 0;
    };
  };

  # === Fish Shell ===

  programs.fish = {
    enable = true;
  };

  # === Bat ===

  programs.bat = {
    enable = true;
  };

  # === fzf ===

  programs.fzf = {
    enable = true;
  };

  # === Helix Editor ===

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
      };
      keys.normal = {
        esc = [
          "collapse_selection"
          "keep_primary_selection"
        ];
      };
    };
  };

  # === Zoxide ===

  programs.zoxide.enable = true;

  # === Zellij ===

  programs.zellij = {
    enable = true;
  };

  xdg.configFile."zellij/layouts" = {
    source = ./resources/Zellij-Layouts;
    recursive = true;
  };

  # === Lazygit ===

  programs.lazygit = {
    enable = true;
    settings = {
      git.paging = {
        colorArg = "never";
        externalDiffCommand = "difft --color=always";
      };
    };
  };

  # === Git ===

  programs.git = {
    enable = true;
    userName = "Xaver106";
    userEmail = "xaver106@posteo.de";
    signing = {
      key = "C6FA3738B20EAC2D7CCF68DA545F10AE238F7DBD";
      signByDefault = true;
    };
    difftastic.enable = true;
  };

  # === EZA ===

  programs.eza = {
    enable = true;
    icons = "auto";
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
          rev = "84db73d0a50a8c6085b3ec63f834c781b603e83e";
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

  programs.btop = {
    enable = true;
  };

  # === Custom Files ===

  home.file."Taskfile.yml".source = ./resources/Taskfile.yml;

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

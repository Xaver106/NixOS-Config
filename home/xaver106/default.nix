{ config, pkgs, ... }:

{
  home.username = "xaver106";
  home.homeDirectory = "/home/xaver106";



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
    extraOptions = [ "--group-directories-first" ];
  };
  
  # TODO: Add Plugins
  programs.ranger.enable = true;

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
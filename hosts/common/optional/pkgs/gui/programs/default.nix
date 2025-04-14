{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.pkgs.gui.programs;
in
{
  imports = [
    ./firefox.nix
    ./obs.nix
  ];

  options.common.optional.pkgs.gui.programs = {
    enable = mkEnableOption "GUI Programs";
  };

  config.common.optional.pkgs.gui.programs = {
    firefox.enable = mkDefault cfg.enable;
    obs.enable = mkDefault cfg.enable;
  };

}

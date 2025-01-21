{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.pkgs;
in
{
  imports = [
    ./base.nix
    ./calculators.nix
    ./dev.nix
    ./latex.nix
    ./security.nix

    ./gui
  ];

  options.common.optional.pkgs = {
    enable = mkEnableOption "All packages";
  };

  config.common.optional.pkgs = {
    base.enable = mkDefault cfg.enable;
    calculators.enable = mkDefault cfg.enable;
    dev.enable = mkDefault cfg.enable;
    gui.enable = mkDefault cfg.enable;
    latex.enable = mkDefault cfg.enable;
    security.enable = mkDefault cfg.enable;
  };

}

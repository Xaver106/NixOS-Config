{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.specialisations;
in
{
  imports = [
    ./isolated.nix
  ];

  options.common.optional.specialisations = {
    enable = mkEnableOption "All packages";
  };

  config.common.optional.specialisations = {
    isolated.enable = mkDefault cfg.enable;
  };

}

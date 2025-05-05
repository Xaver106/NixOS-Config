{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.pkgs.gui.dddprinting;
in
{

  options.common.optional.pkgs.gui.dddprinting = {
    enable = mkEnableOption "3D Printing tools";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      prusa-slicer # 3D Printer Slicer
      freecad-wayland # General purpose Open Source 3D CAD/MCAD/CAx/CAE/PLM modeler
    ];

  };
}

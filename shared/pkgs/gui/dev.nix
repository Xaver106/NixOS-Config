{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.shared.pkgs.gui.dev;
in {
  options.shared.pkgs.gui.dev = {
    enable = mkEnableOption "GUI development packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # IDEs
      vscode              # Visual Studio Code
      zed-editor # High-performance, multiplayer code editor from the creators of Atom and Tree-sitter
      jetbrains-toolbox  # JetBrains IDE manager (IntelliJ, PyCharm, etc.)

      # Text Editors
      kate               # KDE Advanced Text Editor

      # Version Control
      gittyup           # Git GUI client
    ];
  };
}

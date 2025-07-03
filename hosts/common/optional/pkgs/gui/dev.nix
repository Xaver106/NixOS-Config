{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.pkgs.gui.dev;
in
{
  options.common.optional.pkgs.gui.dev = {
    enable = mkEnableOption "GUI development packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # IDEs
      vscode # Visual Studio Code
      jetbrains-toolbox # JetBrains IDE manager (IntelliJ, PyCharm, etc.)

      # Text Editors
      kdePackages.kate # KDE Advanced Text Editor

      # Version Control
      gittyup # Git GUI client

      # SQLite Browser
      sqlitebrowser

      # Toolboxes
      devtoolbox # Development tools at your fingertips
    ];
  };
}

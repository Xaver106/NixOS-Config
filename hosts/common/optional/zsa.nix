{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.zsa;
in
{

  options.common.optional.zsa = {
    enable = mkEnableOption "ZSA Hardware Support";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      keymapp # Application for ZSA keyboards
    ];

    hardware.keyboard.zsa.enable = true;

  };
}

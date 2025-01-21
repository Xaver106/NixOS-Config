{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.ai;
in
{

  options.common.optional.ai = {
    enable = mkEnableOption "AI models";
    # TODO: Add option to choose between cuda and opencl
  };

  config = mkIf cfg.enable {

    services.ollama = {
      enable = true;
      acceleration = "cuda";
    };

    services.open-webui.enable = true;

  };
}

{config, pkgs, lib, ...}:
with lib;

let cfg = config.shared.ai;
in {

  options.shared.ai = {
    enable = mkEnableOption "AI models";
    # TODO: Add option to choose between cuda and opencl
  };

  config = mkIf cfg.enable {

    services.ollama = {
      enable = true;
      acceleration = "cuda";
    };

  };
}

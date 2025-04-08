{config, pkgs, lib, ...}:
with lib;

let cfg = config.common.optional.virtualisation;
in {

  options.common.optional.virtualisation = {
    enable = mkEnableOption "Virtualisation";
  };

  config = mkIf cfg.enable {
    
    environment.systemPackages = with pkgs; [
      qemu
      quickemu
    ];

    virtualisation = {
      libvirtd.enable = true;
      waydroid.enable = true;
    };

    # if you use libvirtd on a desktop environment
    programs.virt-manager.enable = true; # can be used to manage non-local hosts as well

    # Docker, hope I don't need to explain
    virtualisation.docker.enable = true;

  };
}

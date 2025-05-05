{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{

  imports = [
    # inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    sops
  ];

}

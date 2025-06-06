{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.pkgs.latex;
in
{
  options.common.optional.pkgs.latex = {
    enable = mkEnableOption "LaTeX environment";
    full = mkEnableOption "Full TeX Live installation";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Core - based on full vs minimal
      (if cfg.full then texlive.combined.scheme-full else texlive.combined.scheme-basic)

      # Modern Engine
      tectonic # Modern LaTeX engine

      # Development Tools
      texlab # LaTeX LSP
      bibtex-tidy # BibTeX formatter
      jabref # Reference manager for LaTeX
    ];
  };
}

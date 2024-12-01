{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.shared.pkgs.dev;
in
{
  options.shared.pkgs.dev = {
    enable = mkEnableOption "Development packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Version Control tools
      lazygit # Terminal UI for git
      ydiff # View colored, incremental diff in workspace or from stdin with side by side and auto pager support

      # Build Tools
      maven # Java build tool
      gradle # Java build tool
      go-task # Task runner

      # Python
      python3
      python312Packages.python-lsp-server
      python312Packages.python-lsp-ruff
      python312Packages.pylsp-rope
      python312Packages.pylsp-mypy
      python312Packages.pyls-memestra
      python312Packages.pyls-isort

      # Rust
      cargo # Rust package manager
      rustup # Rust toolchain manager
      rust-analyzer # Rust LSP

      # Go
      go # Go compiler
      gopls # Go LSP
      delve # Go debugger

      # JavaScript/Node
      nodejs
      bun              # JS runtime/bundler
      nodePackages_latest.typescript
      nodePackages_latest.typescript-language-server
      nodePackages_latest.vscode-json-languageserver

      # Java
      # jdk Installed trough programs.java
      jdt-language-server

      # Lua
      lua
      lua-language-server

      # C/C++
      gcc # GNU Compiler Collection
      clang # LLVM Compiler
      clang-tools # Clang tools
      lldb # Debugger

      # Haskell
      haskell-language-server

      # Prolog
      swi-prolog

      # Nix
      nil # Nix LSP
      nixd
      nixfmt-rfc-style # Nix formatter

      # Typst
      typst # Markup-based typesetting
      typst-lsp # Typst LSP
    ];

    programs.java.enable = true;
  };
}

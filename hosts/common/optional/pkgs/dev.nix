{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.pkgs.dev;
in
{
  options.common.optional.pkgs.dev = {
    enable = mkEnableOption "Development packages";

    features = mkOption {
      type = types.listOf (
        types.enum [
          "python"
          "rust"
          "go"
          "js"
          "java"
          "c"
          "nix"
          "typst"
          "yaml"
          "markdown"
          "toml"
        ]
      );
      default = [
        "python"
        "rust"
        "go"
        "js"
        "java"
        "c"
        "nix"
        "typst"
        "yaml"
        "markdown"
        "toml"
      ];
      description = "List of language related pkgs to enable.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      with pkgs;
      [

        # Formatter
        treefmt # one CLI to format the code tree

      ]
      ++ optionals (elem "python" cfg.features) [
        # Python
        python3
        python312Packages.python-lsp-server
        python312Packages.python-lsp-ruff
        python312Packages.pylsp-rope
        python312Packages.pylsp-mypy
        python312Packages.pyls-memestra
        python312Packages.pyls-isort

      ]
      ++ optionals (elem "rust" cfg.features) [
        # Rust
        cargo # Rust package manager
        rustup # Rust toolchain manager
        rust-analyzer # Rust LSP

      ]
      ++ optionals (elem "go" cfg.features) [
        # Go
        go # Go compiler
        gopls # Go LSP
        delve # Go debugger

      ]
      ++ optionals (elem "js" cfg.features) [
        # JavaScript/Node
        nodejs
        bun # JS runtime/bundl"er
        nodePackages_latest.typescript
        nodePackages_latest.typescript-language-server
        nodePackages_latest.vscode-json-languageserver

      ]
      ++ optionals (elem "java" cfg.features) [
        # Java
        # jdk Installed trough programs.java
        jdt-language-server
        maven # Java build tool
        gradle # Java build tool

      ]
      ++ optionals (elem "c" cfg.features) [
        # C/C++
        gcc # GNU Compiler Collection
        clang # LLVM Compiler
        clang-tools # Clang tools
        lldb # Debugger

      ]
      ++ optionals (elem "nix" cfg.features) [
        # Nix
        nil # Nix LSP
        nixd
        nixfmt-rfc-style # Nix formatter

      ]
      ++ optionals (elem "typst" cfg.features) [
        # Typst
        typst # Markup-based typesetting
        tinymist # Typst LSP

      ]
      ++ optionals (elem "yaml" cfg.features) [
        # Yaml
        yaml-language-server # Language Server for YAML Files

      ]
      ++ optionals (elem "markdown" cfg.features) [
        # Markdown
        marksman # Language Server for Markdown

      ]
      ++ optionals (elem "toml" cfg.features) [
        # TOML
        taplo # TOML toolkit
      ];

    programs = {
      java = {
        enable = (elem "java" cfg.features);
        package = pkgs.jdk23;
      };

      # Per directory Development Environment
      direnv.enable = mkDefault true;
    };

  };
}

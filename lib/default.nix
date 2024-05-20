{ lib, ... }:
{
  relativeToRoot = lib.path.append ../.;

  nixFilesIn = dir: lib.attrsets.mapAttrsToList (name: _: name) (lib.attrsets.filterAttrs (name: value: value == "regular" && lib.strings.hasSuffix ".nix" name) (builtins.readDir dir)); 
}

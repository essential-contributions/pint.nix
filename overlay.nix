{ yurt-src }:
# An overlay that adds yurt and any necessary dependencies.
final: prev: {
  yurt = prev.callPackage ./default.nix { inherit yurt-src; };
}

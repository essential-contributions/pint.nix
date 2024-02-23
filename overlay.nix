{ yurt-src }:
# An overlay that adds yurt and any necessary dependencies.
final: prev: {
  scip = prev.callPackage ./pkgs/scip.nix { };
  yurt = final.callPackage ./default.nix { inherit yurt-src; };
  yurtWithSolver = final.callPackage ./default.nix {
    inherit yurt-src;
    enableSolver = true;
  };
}

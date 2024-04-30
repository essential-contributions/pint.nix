{ pint-src }:
# An overlay that adds pint and any necessary dependencies.
final: prev: {
  scip = prev.callPackage ./pkgs/scip.nix { };
  pint = final.callPackage ./default.nix { inherit pint-src; };
  pintWithSolver = final.callPackage ./default.nix {
    inherit pint-src;
    enableSolver = true;
  };
}

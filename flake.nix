{
  description = ''
    A nix flake for Pint, the intent solving language.
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    pint-src = {
      url = "git+ssh://git@github.com/essential-contributions/pint";
      flake = false;
    };
  };

  outputs = inputs:
    let
      overlays = [ inputs.self.overlays.default ];
      perSystemPkgs = f:
        inputs.nixpkgs.lib.genAttrs (import inputs.systems)
          (system: f (import inputs.nixpkgs { inherit overlays system; }));
    in
    {
      overlays = {
        pint = import ./overlay.nix { inherit (inputs) pint-src; };
        default = inputs.self.overlays.pint;
      };

      packages = perSystemPkgs (pkgs: {
        scip = pkgs.scip;
        pint = pkgs.pint;
        pintWithSolver = pkgs.pintWithSolver;
        default = inputs.self.packages.${pkgs.system}.pintWithSolver;
      });

      devShells = perSystemPkgs (pkgs: {
        pint-dev = pkgs.callPackage ./shell.nix { };
        default = inputs.self.devShells.${pkgs.system}.pint-dev;
      });

      apps = perSystemPkgs (pkgs: {
        pint = {
          type = "app";
          program = "${pkgs.pint}/bin/pint";
        };
        pintc = {
          type = "app";
          program = "${pkgs.pint}/bin/pintc";
        };
        pintfmt = {
          type = "app";
          program = "${pkgs.pint}/bin/pintfmt";
        };
      });

      formatter = perSystemPkgs (pkgs: pkgs.nixpkgs-fmt);
    };
}

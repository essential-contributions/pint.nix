{
  description = ''
    A nix flake for Yurt, the intent solving language.
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    yurt-src = {
      url = "git+ssh://git@github.com/essential-contributions/yurt";
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
        yurt = import ./overlay.nix { inherit (inputs) yurt-src; };
        default = inputs.self.overlays.yurt;
      };

      packages = perSystemPkgs (pkgs: {
        scip = pkgs.scip;
        yurt = pkgs.yurt;
        yurtWithSolver = pkgs.yurtWithSolver;
        default = inputs.self.packages.${pkgs.system}.yurtWithSolver;
      });

      devShells = perSystemPkgs (pkgs: {
        yurt-dev = pkgs.callPackage ./shell.nix { };
        default = inputs.self.devShells.${pkgs.system}.yurt-dev;
      });

      apps = perSystemPkgs (pkgs: {
        yurtc = {
          type = "app";
          program = "${pkgs.yurt}/bin/yurtc";
        };
        yurtfmt = {
          type = "app";
          program = "${pkgs.yurt}/bin/yurtfmt";
        };
      });

      formatter = perSystemPkgs (pkgs: pkgs.nixpkgs-fmt);
    };
}

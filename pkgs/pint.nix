{ enableSolver ? false
, lib
, libclang
, runCommand
, rustPlatform
, scip
, stdenv
, pint-src
}:
let
  # Normally we don't need anything like this for bindgen as
  # `rustPlatform.bindgenHook` takes care of this for us, but it seems in some
  # cases it cannot :') in our case, it couldn't find "stdio.h". Here's where I
  # found this solution: https://hoverbear.org/blog/rust-bindgen-in-nix/.
  # Here, we generate the extra bindgen clang args so that we can assign them to
  # the relevant env var.
  bindgenExtraClangArgs = runCommand "bindgen-extra-clang-args.txt" { } ''
    cat ${stdenv.cc}/nix-support/libc-crt1-cflags \
      ${stdenv.cc}/nix-support/libc-cflags \
      ${stdenv.cc}/nix-support/cc-cflags \
      ${stdenv.cc}/nix-support/libcxx-cxxflags > $out
    echo "${lib.optionalString stdenv.cc.isClang "-idirafter ${stdenv.cc.cc}/lib/clang/${lib.getVersion stdenv.cc.cc}/include"}" >> $out
    echo "${lib.optionalString stdenv.cc.isGNU "-isystem ${stdenv.cc.cc}/include/c++/${lib.getVersion stdenv.cc.cc} -isystem ${stdenv.cc.cc}/include/c++/${lib.getVersion stdenv.cc.cc}/${stdenv.hostPlatform.config} -idirafter ${stdenv.cc.cc}/lib/gcc/${stdenv.hostPlatform.config}/${lib.getVersion stdenv.cc.cc}/include"}" >> $out
  '';
in
rustPlatform.buildRustPackage rec {
  pname = "pint";
  version = (builtins.fromTOML (builtins.readFile "${src}/pintc/Cargo.toml")).package.version;
  src = pint-src;

  buildNoDefaultFeatures = !enableSolver;

  nativeInputs = lib.optionals enableSolver [
    rustPlatform.bindgenHook
  ];

  buildInputs = lib.optionals enableSolver [
    libclang
    scip
  ];

  env = lib.optionalAttrs enableSolver {
    BINDGEN_EXTRA_CLANG_ARGS = builtins.readFile bindgenExtraClangArgs;
    LIBCLANG_PATH = lib.makeLibraryPath [ libclang ];
    SCIPOPTDIR = scip;
  };

  doCheck = false; # CI-tested upstream.
  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}

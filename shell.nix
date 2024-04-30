{ cargo-nextest
, mkShell
, pintWithSolver
}:
mkShell {
  inputsFrom = [
    pintWithSolver
  ];
  buildInputs = [
    cargo-nextest
  ];
  env = {
    inherit (pintWithSolver) BINDGEN_EXTRA_CLANG_ARGS LIBCLANG_PATH SCIPOPTDIR;
  };
}

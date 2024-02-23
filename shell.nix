{ cargo-nextest
, mkShell
, yurtWithSolver
}:
mkShell {
  inputsFrom = [
    yurtWithSolver
  ];
  buildInputs = [
    cargo-nextest
  ];
  env = {
    inherit (yurtWithSolver) BINDGEN_EXTRA_CLANG_ARGS LIBCLANG_PATH SCIPOPTDIR;
  };
}

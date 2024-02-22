{ cargo-nextest
, mkShell
, yurt
}:
mkShell {
  inputsFrom = [
    yurt
  ];
  buildInputs = [
    cargo-nextest
    # Any required build-time / system deps for yurt
  ];
}

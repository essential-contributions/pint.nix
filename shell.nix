{ mkShell
, yurt
}:
mkShell {
  inputsFrom = [
    yurt
  ];
  buildInputs = [
    # Any required build-time / system deps for yurt
  ];
}

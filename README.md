# pint.nix

A Nix flake for the Pint intent language.

*Supports Linux & macOS.*

## Usage

1. Install Nix, easiest with the [Determinate Systems installer](https://github.com/DeterminateSystems/nix-installer).

2. Use Nix to enter a shell with the `pint`, `pintc` and `pintfmt` CLIs:

   ```console
   nix shell github:essential-contributions/pint.nix
   ```

   By default, this installs `pintc` with solving capabilities (via the
   `pintWithSolver` package) by binding to `scip`. To build `pintc` purely with
   constraint checking capabilities, you can use:

   ```console
   nix shell github:essential-contributions/pint.nix#pint
   ```

3. Check that it works with:
   ```console
   pint -h
   ```

## Developing pint

If you're working on the pint repo itself, the following command can be
useful. It allows you to enter a development shell with all of the necessary
dependencies and environment variables to build pint with solving enabled and
run the tests. This includes, rust, scip, clang (for bindgen), etc.

```console
nix develop github:essential-contributions/pint.nix
```

Now when you run `cargo build` or `cargo nextest run`, bindgen will bind to the
scip libraries installed by Nix (rather than downloading them at build time). We
can check this works with the following:

```console
$ cd /path/to/pint

$ cargo nextest run
```

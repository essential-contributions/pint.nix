# yurt.nix

A Nix flake for the Yurt intent language.

*Supports Linux & macOS.*

## Usage

1. Install Nix, easiest with the [Determinate Systems installer](https://github.com/DeterminateSystems/nix-installer).

2. Use Nix to enter a shell with the `yurtc` and `yurtfmt` CLIs:

   ```console
   nix shell git+ssh://git@github.com/essential-contributions/yurt.nix
   ```

   By default, this installs `yurtc` with solving capabilities (via the
   `yurtWithSolver` package) by binding to `scip`. To build `yurtc` purely with
   constraint checking capabilities, you can use:

   ```console
   nix shell git+ssh://git@github.com/essential-contributions/yurt.nix#yurt
   ```

3. Check that it works with:
   ```console
   yurtc -h
   ```

## Developing yurt

If you're working on the yurt repo itself, the following command can be useful
to enter a "development" environment with all of the necessary dependencies and
environment variables to build yurt with solving enabled and run the tests.

```console
nix develop git+ssh://git@github.com/essential-contributions/yurt.nix
```

Now when you run `cargo build` or `cargo nextest run`, bindgen will bind to the
scip libraries installed by Nix (rather than downloading them at build time). We
can check this works with the following:

```console
$ cd /path/to/yurt

$ cargo nextest run
```

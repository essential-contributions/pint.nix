# yurt.nix

A Nix flake for the Yurt intent language.

## Usage

1. Install Nix, easiest with the [Determinate Systems installer](https://github.com/DeterminateSystems/nix-installer).

2. Use Nix to enter a shell with the `yurtc` and `yurtfmt` CLIs:

   ```console
   nix shell git+ssh://git@github.com/essential-contributions/yurt.nix
   ```

   > *Note: this will be `nix shell github:essential-contributions/yurt.nix` once the repo is public.*

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

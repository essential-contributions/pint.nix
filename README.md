# yurt.nix

A Nix flake for the Yurt intent language.

## Usage

1. Install Nix, easiest with the [Determinate Systems installer](https://github.com/DeterminateSystems/nix-installer).

2. Use Nix to enter a shell with the `yurtc` and `yurtfmt` CLIs:
   ```console
   nix shell git+ssh://git@github.com/mitchmindtree/yurt.nix
   ```
   *Note: this will be `nix shell github:mitchmindtree/yurt.nix` once the repo is public.*

3. Check that it works with:
   ```console
   yurtc -h
   ```

# yurt.nix

A Nix flake for the Yurt intent language.

## Usage

1. Install Nix, easiest with the [Determinate Systems installer](https://github.com/DeterminateSystems/nix-installer).

2. Use Nix to enter a shell with the `yurtc` and `yurtfmt` CLIs:
   ```console
   nix shell github:mitchmindtree/yurt.nix
   ```

3. Check that it works with:
   ```console
   yurtc -h
   ```

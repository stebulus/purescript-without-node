# purescript-without-node

A Nix setup for using Purescript without Nodejs.

## How to use

1. Install [the Nix package manager][nix].
2. Copy the [`purescript`](purescript) directory to your project.
3. Use the functions from `purescript/default.nix` in your `default.nix`;
   see [`example/default.nix`](example/default.nix) here for an example.

## Why not to use

With this method, there is no automatic dependency resolution.

[nix]: https://nixos.org/nix/

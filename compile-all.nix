/*
    Compile all known Purescript packages.
    For testing this Nix setup.
*/
with builtins;
let nixpkgs = import <nixpkgs> {};
    ps = import ./purescript.nix {
        inherit (nixpkgs) cabal-install;
        inherit (nixpkgs) coreutils;
        inherit (nixpkgs) fetchurl;
        inherit (nixpkgs) findutils;
        inherit (nixpkgs.haskellPackages) ghcWithPackages;
        inherit (nixpkgs) stdenv;
    };
    bind = (f: xs: foldl' (a: b: a ++ f b) [] xs);
    derivationsIn = (x:
        let t = typeOf x; in
        if t == "list"
        then bind derivationsIn x
        else if t == "set"
        then (if x.type or "no-type" == "derivation"
            then [x]
            else derivationsIn (attrValues x))
        else []
    );
in ps.purescriptWithPackages derivationsIn

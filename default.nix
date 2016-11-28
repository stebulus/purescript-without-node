let nixpkgs = import <nixpkgs> {};
    ps = import ./purescript.nix {
        inherit (nixpkgs) cabal-install;
        inherit (nixpkgs) coreutils;
        inherit (nixpkgs) fetchurl;
        inherit (nixpkgs) findutils;
        inherit (nixpkgs.haskellPackages) ghcWithPackages;
        inherit (nixpkgs) stdenv;
    };
in nixpkgs.stdenv.mkDerivation {
    name = "hello-0.1.0";
    src = ./.;
    purescript = ps.purescriptWithPackages (pkgs: [ pkgs.console ]);
    builder = builtins.toFile "builder.sh"
        ''
        source $stdenv/setup
        $purescript/bin/psc $src/Hello.purs
        $purescript/bin/psc-bundle output/'**/*.js' -m Hello --main Hello -o $out/hello.js
        '';
}

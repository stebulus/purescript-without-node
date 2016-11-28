{ mkDerivation, array, base, bytestring, containers, ghc-prim, mtl
, parsec, regex-base, stdenv
}:
mkDerivation {
  pname = "regex-tdfa";
  version = "1.2.2";
  sha256 = "0f8x8wyr6m21g8dnxvnvalz5bsq37l125l6qhs0fscbvprsxc4nb";
  libraryHaskellDepends = [
    array base bytestring containers ghc-prim mtl parsec regex-base
  ];
  homepage = "https://github.com/ChrisKuklewicz/regex-tdfa";
  description = "Replaces/Enhances Text.Regex";
  license = stdenv.lib.licenses.bsd3;
}

{ mkDerivation, async, base, bytestring, containers, deepseq
, ghc-prim, mtl, safe, stdenv, stm, text, transformers
}:
mkDerivation {
  pname = "protolude";
  version = "0.1.10";
  sha256 = "19f7w4n1k3xb3y00b10rxr781yxivl7byh7hrnfk5mzh32jrcchn";
  libraryHaskellDepends = [
    async base bytestring containers deepseq ghc-prim mtl safe stm text
    transformers
  ];
  homepage = "https://github.com/sdiehl/protolude";
  description = "A sensible set of defaults for writing custom Preludes";
  license = stdenv.lib.licenses.mit;
}

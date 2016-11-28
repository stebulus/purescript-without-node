{ mkDerivation, base, bytestring, connection, data-default-class
, hspec, http-client, http-types, network, stdenv, tls
}:
mkDerivation {
  pname = "http-client-tls";
  version = "0.2.4";
  sha256 = "0889zx4rmmil7m86gbj8lvfp393rv98b80769jjfgwggq3cynq6s";
  libraryHaskellDepends = [
    base bytestring connection data-default-class http-client network
    tls
  ];
  testHaskellDepends = [ base hspec http-client http-types ];
  homepage = "https://github.com/snoyberg/http-client";
  description = "http-client backend using the connection package and tls library";
  license = stdenv.lib.licenses.mit;
}

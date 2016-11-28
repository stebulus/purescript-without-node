{ mkDerivation, base, byteable, bytestring, containers
, data-default-class, network, socks, stdenv, tls, x509, x509-store
, x509-system, x509-validation
}:
mkDerivation {
  pname = "connection";
  version = "0.2.6";
  sha256 = "1c1prsgad669cmf6qrqlb5hmh0dnam2imijqzpwcr4ja14l6rh83";
  libraryHaskellDepends = [
    base byteable bytestring containers data-default-class network
    socks tls x509 x509-store x509-system x509-validation
  ];
  homepage = "http://github.com/vincenthz/hs-connection";
  description = "Simple and easy network connections API";
  license = stdenv.lib.licenses.bsd3;
}

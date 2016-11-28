{ mkDerivation, base, bytestring, http-client, http-client-tls
, pipes, stdenv
}:
mkDerivation {
  pname = "pipes-http";
  version = "1.0.4";
  sha256 = "05h2b8684ywqaafv55ifnnqi1ylk8y43fj70vdjilps1kx5zikzm";
  libraryHaskellDepends = [
    base bytestring http-client http-client-tls pipes
  ];
  description = "HTTP client with pipes interface";
  license = stdenv.lib.licenses.bsd3;
}

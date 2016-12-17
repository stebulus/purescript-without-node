{ callPackage }:
rec {
    connection = callPackage ./connection.nix {
        inherit tls;
    };
    http-client = callPackage ./http-client.nix {};
    http-client-tls = callPackage ./http-client-tls.nix {
        inherit connection;
        inherit http-client;
        inherit tls;
    };
    parsec = callPackage ./parsec.nix {};
    pipes-http = callPackage ./pipes-http.nix {
        inherit http-client;
        inherit http-client-tls;
    };
    protolude = callPackage ./protolude.nix {};
    regex-tdfa = callPackage ./regex-tdfa.nix {
        inherit parsec;
    };
    tls = callPackage ./tls.nix {};
}

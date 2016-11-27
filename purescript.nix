{ cabal-install
, coreutils
, fetchurl
, ghcWithPackages
, stdenv
}:
rec {

    purescript = stdenv.mkDerivation {
        name = "purescript-0.8.5";
        src = fetchurl {
            url = https://github.com/purescript/purescript/archive/v0.8.5.tar.gz;
            sha256 = "352c0c311710907d112e5d2745e7b152adc4d7b23aff3f069c463eceedddec17";
        };
        executables = [
            "psc"
            "psc-bundle"
            "psc-docs"
            "psc-hierarchy"
            "psci"
            "psc-ide-client"
            "psc-ide-server"
            "psc-publish"
        ];
        builder = builtins.toFile "builder.sh"
            ''
            source $stdenv/setup
            tar zxf $src
            cd purescript-0.8.5
            cabal --config-file=cabal.config build
            mkdir -p $out/bin
            for f in $executables; do
                cp dist/build/$f/$f $out/bin
                chmod +x $out/bin/$f
            done
            '';
        buildInputs = [
            cabal-install
            (ghcWithPackages (pkgs: with pkgs; [
                aeson
                aeson-better-errors
                ansi-wl-pprint
                base-compat
                bower-json
                boxes
                dlist
                edit-distance
                fsnotify
                Glob
                http-types
                language-javascript
                lifted-base
                monad-control
                monad-logger
                mtl
                network
                optparse-applicative
                parallel
                parsec
                pattern-arrows
                pipes
                pipes-http
                regex-tdfa
                safe
                semigroups
                sourcemap
                spdx
                split
                stm
                syb
                text
                transformers-base
                transformers-compat
                unordered-containers
                utf8-string
                vector
            ]))
        ];
    };

    githubSource = { name, version, sha256 }:
        stdenv.mkDerivation {
            name = "purescript-${name}-${version}";
            src = fetchurl {
                url = "https://github.com/purescript/purescript-${name}/archive/v${version}.tar.gz";
                inherit sha256;
            };
            builder = builtins.toFile "builder.sh"
                ''
                source $stdenv/setup
                tar xf $src
                mkdir -p $out
                cp -R $name/src $out/purs
                '';
        };

    mergePackages = packages: stdenv.mkDerivation {
        name = "merged-purescript-packages-0.1.0";
        inherit packages;
        builder = builtins.toFile "builder.sh"
            ''
            source $stdenv/setup
            mkdir -p $out/purs
            for pkg in $packages; do
                find $pkg/purs -type d |while read dir; do
                    mkdir -p $out/''${dir#$pkg/}
                done
                find $pkg/purs -type f -o -type l |while read file; do
                    target=$(readlink -f $file)
                    link=$out/''${file#$pkg/}
                    if [ ! -e $link ]; then
                        ln -s $target $link
                    elif [ ! -h $link ]; then
                        echo "clash: $link exists, not a symlink, but must also point to $target" >&2
                        exit 1
                    else
                        existing=$(readlink -f $link)
                        if [ $target != $existing ]; then
                            echo "clash: $link -> $existing, but must also point to $target" >&2
                            exit 1
                        fi
                    fi
                done
            done
            '';
    };

    packages = rec {
        console = mergePackages [
            eff
            (githubSource {
                name = "console";
                version = "0.1.1";
                sha256 = "9d1bed960d63d93c4bafd8a9e46229244625f5218eaaa1b672121a496da4b912";
            })
        ];
        eff = mergePackages [
            prelude
            (githubSource {
                name = "eff";
                version = "0.1.1";
                sha256 = "8f309918c9b7ff26542209756b2467ac9c6bbb81fb0a82f1ff3ce190c3f49c4c";
            })
        ];
        prelude = githubSource {
            name = "prelude";
            version = "1.1.0";
            sha256 = "5c931068e33fe9c08fc36bbad0e20701a919f14cc76be2dc146dae9f126ebfab";
        };
    };

    purescriptWithPackages = choosePackages: stdenv.mkDerivation {
        name = "purescript-with-packages-0.1.0";
        builder = builtins.toFile "builder.sh"
            ''
            source $stdenv/setup
            mkdir -p $out/bin
            substituteAll $pscWrapper $out/bin/psc
            chmod +x $out/bin/psc
            ln -s $purescript/bin/psc-bundle $out/bin
            '';
        inherit coreutils;
        inherit purescript;
        pscWrapper = builtins.toFile "psc-wrapper"
            ''
            #!/bin/bash
            @purescript@/bin/psc @mergedPackages@/purs/'**/*.'{js,purs} "$@"
            '';
        mergedPackages = mergePackages (choosePackages packages);
    };

}

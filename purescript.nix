{ cabal-install
, coreutils
, fetchurl
, findutils
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
                cp -a $name/src $out/purs
                '';
        };

    linkMerge = stdenv.mkDerivation {
        name = "link-merge-0.1.0";
        builder = builtins.toFile "builder.sh"
            ''
            source $stdenv/setup
            mkdir -p $out/bin
            substituteAll $src $out/bin/link-merge
            chmod +x $out/bin/link-merge
            '';
        inherit coreutils;
        inherit findutils;
        src = builtins.toFile "link-merge"
            ''
            #!/bin/bash
            set -euo pipefail
            if [ $# -lt 2 ]; then
                echo "usage: $0 subdirname target [input ...]" >&2
                exit 2
            fi
            subdirname=$1
            targetdir=$2
            shift 2
            @coreutils@/bin/mkdir -p $targetdir/$subdirname
            for pkg in "$@"; do
                if test ! -d $pkg/$subdirname; then continue; fi
                @findutils@/bin/find $pkg/$subdirname -type d |
                while read dir; do
                    @coreutils@/bin/mkdir -p $targetdir/''${dir#$pkg/}
                done
                @findutils@/bin/find $pkg/$subdirname -type f -o -type l |
                while read file; do
                    linktarget=$(@coreutils@/bin/readlink -f $file)
                    link=$targetdir/''${file#$pkg/}
                    if test ! -e $link; then
                        @coreutils@/bin/ln -s $linktarget $link
                    elif test ! -h $link; then
                        echo "clash: $link exists, not a symlink, but must also point to $linktarget" >&2
                        exit 1
                    else
                        existing=$(@coreutils@/bin/readlink -f $link)
                        if test $linktarget != $existing; then
                            echo "clash: $link -> $existing, but must also point to $target" >&2
                            exit 1
                        fi
                    fi
                done
            done
            '';
    };

    mergePackages = packages: stdenv.mkDerivation {
        name = "merged-purescript-packages-0.1.0";
        buildInputs = [ purescript linkMerge ];
        inherit packages;
        builder = builtins.toFile "builder.sh"
            ''
            source $stdenv/setup
            link-merge purs $out $packages
            link-merge output $out $packages
            psc --output $out/output $out/purs/'**/*.'{purs,js}
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
        prelude = mergePackages [
            (githubSource {
                name = "prelude";
                version = "1.1.0";
                sha256 = "5c931068e33fe9c08fc36bbad0e20701a919f14cc76be2dc146dae9f126ebfab";
            })
        ];
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
            ln -s $mergedPackages/output $out/output
            '';
        inherit coreutils;
        inherit purescript;
        pscWrapper = builtins.toFile "psc-wrapper"
            ''
            #!/bin/bash
            outputdir() {
                while test $# -gt 0 && test ! -v output; do
                    case "$1" in
                        --output | -o)
                            if test $# -eq 1; then
                                echo "$0: missing argument for --output/-o" >&2
                                return 1
                            fi
                            output=$2
                            break
                            ;;
                        --output=*)
                            output=''${1#--output=}
                            break
                            ;;
                        -o*)
                            output=''${1#-o}
                            break
                            ;;
                        *)
                            ;;
                    esac
                    shift
                done
                echo ''${output:-./output}
            }
            d=$(outputdir "$@")
            @coreutils@/bin/mkdir -p "$d"
            @coreutils@/bin/cp -a @mergedPackages@/output/* "$d"
            @purescript@/bin/psc @mergedPackages@/purs/'**/*.'{js,purs} "$@"
            '';
        mergedPackages = mergePackages (choosePackages packages);
    };

}

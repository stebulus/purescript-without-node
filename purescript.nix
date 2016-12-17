{ cabal-install
, coreutils
, fetchurl
, findutils
, ghcWithPackages
, stdenv
}:
rec {

    purescript = stdenv.mkDerivation (rec {
        name = "purescript-${version}";
        version = "0.10.2";
        src = fetchurl {
            url = "https://github.com/purescript/purescript/archive/v${version}.tar.gz";
            sha256 = "4b5663e2a5ebb7a2e432f951d0a5d0ddfa08f18304827ec33f609d9b3c1c3fe7";
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
            cd purescript-${version}
            cabal --config-file=cabal.config build
            mkdir -p $out/bin
            for f in $executables; do
                cp dist/build/$f/$f $out/bin
                chmod +x $out/bin/$f
            done
            '';
        buildInputs = [
            cabal-install
            (ghcWithPackages (pkgs:
                with pkgs;
                with (import ./haskell-package-overrides
                  { inherit pkgs; });
                [
                    aeson-better-errors
                    aeson-pretty
                    ansi-terminal
                    ansi-wl-pprint
                    base-compat
                    bower-json
                    boxes
                    clock
                    data-ordlist
                    edit-distance
                    file-embed
                    fsnotify
                    Glob
                    http-client
                    http-types
                    language-javascript
                    lens
                    lifted-base
                    monad-control
                    monad-logger
                    network
                    optparse-applicative
                    parallel
                    parsec
                    pattern-arrows
                    pipes
                    pipes-http
                    protolude
                    regex-tdfa
                    safe
                    sourcemap
                    spdx
                    split
                    stm
                    system-filepath
                    transformers-base
                    transformers-compat
                    turtle
                    utf8-string
                    wai
                    wai-websockets
                    warp
                    websockets
                ]
            ))
        ];
    });

    githubSource = { name, version, sha256, owner ? "purescript" }:
        stdenv.mkDerivation {
            name = "purescript-${name}-${version}";
            src = fetchurl {
                url = "https://github.com/${owner}/purescript-${name}/archive/v${version}.tar.gz";
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

    compile = { name, packages }: stdenv.mkDerivation {
        inherit name;
        inherit packages;
        buildInputs = [ purescript linkMerge ];
        builder = builtins.toFile "builder.sh"
            ''
            source $stdenv/setup
            link-merge purs $out $packages
            link-merge output $out $packages
            psc --output $out/output $out/purs/'**/*'.purs
            '';
    };

    compilePackage = { package, dependencies }: compile {
        name = "${package.name}-compiled";
        packages = [package] ++ dependencies;
    };

    packages = import ./packages.nix {
        inherit compilePackage;
        inherit githubSource;
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
            ln -s $compiled/output $out/output
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
            @coreutils@/bin/cp -a @compiled@/output/* "$d"
            @purescript@/bin/psc @compiled@/purs/'**/*'.purs "$@"
            '';
        compiled = compile {
            name = "purescript-packages";
            packages = (choosePackages packages);
        };
    };

}

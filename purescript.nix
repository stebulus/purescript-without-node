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
                with (import overrides/together.nix { inherit pkgs; });
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

    mergePackages = packages: stdenv.mkDerivation {
        name = "merged-purescript-packages-0.1.0";
        buildInputs = [ purescript linkMerge ];
        inherit packages;
        builder = builtins.toFile "builder.sh"
            ''
            source $stdenv/setup
            link-merge purs $out $packages
            link-merge output $out $packages
            psc --output $out/output $out/purs/'**/*'.purs
            '';
    };

    packages = rec {

        arrays = mergePackages [
            foldable-traversable
            nonempty
            partial
            st
            tailrec
            tuples
            unfoldable
            (githubSource {
                name = "arrays";
                version = "3.1.0";
                sha256 = "0z990j7f3p24wqc6pd8fmpx61b3b51xxdjzghiiixazxp53spjq5";
            })
        ];

        bifunctors = mergePackages [
            control
            newtype
            (githubSource {
                name = "bifunctors";
                version = "2.0.0";
                sha256 = "1gfvyw95x523gmpvh8qav7bq2rnp19xmczg9ivcxv243w6d89cwx";
            })
        ];

        console = mergePackages [
            eff
            (githubSource {
                name = "console";
                version = "2.0.0";
                sha256 = "0raqjwkdgl788lphljwmrzkpyaah60hra3nnb9wbhbf5qdk86c6k";
            })
        ];

        control = mergePackages [
            prelude
            (githubSource {
                name = "control";
                version = "2.0.0";
                sha256 = "07rvmhp6942pcng67mpva1nmi59aj2mayzi2m3311f430pc25v9i";
            })
        ];

	datetime = mergePackages [
	    enums
	    functions
	    generics
	    integers
	    math
	    (githubSource {
		name = "datetime";
		version = "2.0.0";
		sha256 = "e1760e6e842881b7f272dc8041d8439e3185444638baf69264bc1d0f72d5b0b9";
	    })
	];

        distributive = mergePackages [
            identity
            (githubSource {
                name = "distributive";
                version = "2.0.0";
                sha256 = "d9ac7889550699e0ba61c974f6952b2d8922d42903a286ca69a65d8f92bc8532";
            })
        ];

        eff = mergePackages [
            prelude
            (githubSource {
                name = "eff";
                version = "2.0.0";
                sha256 = "0kxi5d7cqv3a7q9d8sskjpr8bccw1l2g4y4a8yjcwk4hyamn5w1p";
            })
        ];

        either = mergePackages [
            foldable-traversable
            (githubSource {
                name = "either";
                version = "2.0.0";
                sha256 = "009vnssmqp2vj1x1c9sp9kx62ax58bmpm0pv10qrmw9ppmhlgh1h";
            })
        ];

        enums = mergePackages [
            control
            strings
            tuples
            unfoldable
            (githubSource {
                name = "enums";
                version = "2.0.1";
                sha256 = "0lr9vj111i4zwzq41mz898grkadjq45pfpm6gxk2z6zysw8gf01n";
            })
        ];

	exceptions = mergePackages [
	    eff
	    either
	    maybe
	    (githubSource {
		name = "exceptions";
		version = "2.0.0";
		sha256 = "4d9076bb7c1627bbb081c2f0b38bf03692a57fa242d0c35d4a59df1bfd48537d";
	    })
	];

        foldable-traversable = mergePackages [
            bifunctors
            maybe
            (githubSource {
                name = "foldable-traversable";
                version = "2.0.0";
                sha256 = "0a046g6aa99ayhxl510mdmkga5gy4fh3sc1ccxbvc8r11gd24pvf";
            })
        ];

        foreign = mergePackages [
            arrays
            either
            foldable-traversable
            functions
            integers
            lists
            strings
            transformers
            (githubSource {
                name = "foreign";
                version = "3.0.1";
                sha256 = "0x188ivz3dp1gx8njzxjl40yafsjy533cakrz9w09zgrcw9vi57r";
            })
        ];

        functions = mergePackages [
            prelude
            (githubSource {
                name = "functions";
                version = "2.0.0";
                sha256 = "1m417pz272bf4ailqjb0xpx6j6r0sblydia431vzvfpm1gzk6125";
            })
        ];

        generics = mergePackages [
            arrays
            either
            identity
            proxy
            strings
            (githubSource {
                name = "generics";
                version = "3.1.0";
                sha256 = "01kjqb7kcn3wywzjxzr7qqivhdnvh8xxw0srklfcqz5yj87ak03b";
            })
        ];

	identity = mergePackages [
	    foldable-traversable
	    (githubSource {
		name = "identity";
		version = "2.0.0";
		sha256 = "60828516e975a2415bbd9455b81ad55a650a8e78aed40d1b8abf7ac348e0f268";
	    })
	];

        integers = mergePackages [
            maybe
            math
            partial
            (githubSource {
                name = "integers";
                version = "2.1.0";
                sha256 = "1haxg58nxhq7zwp5i17gn55xqpqiq7iffyr8rj2i42qdwbz6gng5";
            })
        ];

        invariant = mergePackages [
            prelude
            (githubSource {
                name = "invariant";
                version = "2.0.0";
                sha256 = "15wc8al429p8fp3s36largrhk8jrc4pbyc776d1cq2163wy07cvb";
            })
        ];

        lazy = mergePackages [
            monoid
            (githubSource {
                name = "lazy";
                version = "2.0.0";
                sha256 = "1j1g6xnigmqwvc3bcx0ipzrbbzkvfwrbdh849fwybc6mdbjbjam6";
            })
        ];

        lists = mergePackages [
            generics
            lazy
            unfoldable
            (githubSource {
                name = "lists";
                version = "3.2.1";
                sha256 = "1m5f1p1yqa34dwxq67l7cqz3r3dnmpljjcy5hck0pd67rkcs5ifi";
            })
        ];

        math = mergePackages [
            (githubSource {
                name = "math";
                version = "2.0.0";
                sha256 = "3f31609f7005393af461d472edb45c0e99d70ce669af8474cbbd6105cdbbf4b2";
            })
        ];

        maybe = mergePackages [
            control
            invariant
            monoid
            (githubSource {
                name = "maybe";
                version = "2.0.1";
                sha256 = "1xmn3i3d90nwwy28plyaasxxwxkiq84f12jzxdckw79386j1xg1s";
            })
        ];

        monoid = mergePackages [
            control
            invariant
            newtype
            (githubSource {
                name = "monoid";
                version = "2.2.0";
                sha256 = "1azax4i5l0zsiw44nfdl2m1bpjbicpzs0kxb6rdv3xwjmaqc3l0y";
            })
        ];

        newtype = mergePackages [
            prelude
            (githubSource {
                name = "newtype";
                version = "1.1.0";
                sha256 = "0xr5fjcyd4lz6g9fx7dzbcx3swhy2f94wh7k5w4iqsr32h412y6z";
            })
        ];

        nonempty = mergePackages [
            foldable-traversable
            (githubSource {
                name = "nonempty";
                version = "3.0.0";
                sha256 = "13jpd4b6wa3fjgmchxk4fiyhkdgafswiwivhl82w6kd6slsqid4b";
            })
        ];

        partial = mergePackages [
            (githubSource {
                name = "partial";
                version = "1.1.2";
                sha256 = "0kl7m1bvxyy7wnrghkkvdxqx9m6yr6iyndccda7bwzl2lkwf05ac";
            })
        ];

        prelude = mergePackages [
            (githubSource {
                name = "prelude";
                version = "2.1.0";
                sha256 = "1pmiffdigp5hj22mwsl6wapj8ykn5an42ksn6w3cdd1m0m6jl8f1";
            })
        ];

        proxy = mergePackages [
            (githubSource {
                name = "proxy";
                version = "1.0.0";
                sha256 = "220ef0ff8a74f8aed2fd029e52b92b355980ed1bbe1989acaaa846cb177b00b6";
            })
        ];

        st = mergePackages [
            eff
            (githubSource {
                name = "st";
                version = "2.0.0";
                sha256 = "0xhpnw8dq2k3aigv6a2vii53hbj497p52ypij9n3n3s8ncya0a72";
            })
        ];

        strings = mergePackages [
            either
            maybe
            (githubSource {
                name = "strings";
                version = "2.0.2";
                sha256 = "1wbxv9ssij3f6i68bynl2pmpah3b9r0vija5djjk74qnq5kp7jzj";
            })
        ];

        tailrec = mergePackages [
            identity
            either
            st
            partial
            (githubSource {
                name = "tailrec";
                version = "2.0.1";
                sha256 = "1lglhkq8ni8x9mv0k9g8na3ny5aqk44ijh7h87pxxxfndky10fbm";
            })
        ];

        transformers = mergePackages [
            arrays
            lazy
            distributive
            tuples
            (githubSource {
                name = "transformers";
                version = "2.0.2";
                sha256 = "1ghbyjnnkkasgwi07fyz6gcv4g35hmpwrgbmm5pa2p7zmlhfy2vc";
            })
        ];

        tuples = mergePackages [
            foldable-traversable
            (githubSource {
                name = "tuples";
                version = "3.0.0";
                sha256 = "0gippg8aaa77qsl7im4crqx2993k6xlz8z4iyld9axc0wqwas3px";
            })
        ];

        unfoldable = mergePackages [
            partial
            tuples
            (githubSource {
                name = "unfoldable";
                version = "2.0.0";
                sha256 = "1c29klc4dbv8hmmnwaqfg475sg53156cms1azymsfzk0baislpxl";
            })
        ];

	unsafe-coerce = mergePackages [
	    (githubSource {
		name = "unsafe-coerce";
		version = "2.0.0";
		sha256 = "b72cad40db46648454c67ad1c9ffdd7620961cfd11ca03707a9ab6029a3d644f";
	    })
	];

        contrib = rec {

	    dom = mergePackages [
		datetime
		enums
		exceptions
		foldable-traversable
		foreign
		js-date
		media-types
		nullable
		prelude
		unsafe-coerce
		(githubSource {
		    name = "dom";
		    version = "3.3.0";
		    sha256 = "685152367927f2e15485bec513a21c785129e34e83139f3e736ccf967e0b01b4";
                    owner = "purescript-contrib";
		})
	    ];

	    js-date = mergePackages [
		datetime
		exceptions
		foreign
		integers
		(githubSource {
		    name = "js-date";
		    version = "3.0.0";
		    sha256 = "c52a9455a856f6164c4c8a2f843928b6d7411189712681d2cd7a5fbc36f5fc17";
                    owner = "purescript-contrib";
		})
	    ];

	    media-types = mergePackages [
		generics
		(githubSource {
		    name = "media-types";
		    version = "2.0.0";
		    sha256 = "a1b44d1c33c04cbb8b67d39bf647f66cbd433b5f70706d65cb2e05c03da73e92";
                    owner = "purescript-contrib";
		})
	    ];

	    nullable = mergePackages [
		functions
		maybe
		(githubSource {
		    name = "nullable";
		    version = "2.0.0";
		    sha256 = "cd55633ad15e46c27bfe849c3475f756c73842645712ba70d27a86a8364ced06";
                    owner = "purescript-contrib";
		})
	    ];

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
            @purescript@/bin/psc @mergedPackages@/purs/'**/*'.purs "$@"
            '';
        mergedPackages = mergePackages (choosePackages packages);
    };

}

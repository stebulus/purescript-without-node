{ compilePackage, githubSource }: rec {

arrays = compilePackage {
    package = githubSource {
        name = "arrays";
        version = "3.1.0";
        sha256 = "05cbab47b9fdab1e6384efcbd67b286bac60faad0eb56b18e644dce18e04297d";
    };
    dependencies = [
        foldable-traversable
        nonempty
        partial
        st
        tailrec
        tuples
        unfoldable
    ];
};

"assert" = compilePackage {
    package = githubSource {
        name = "assert";
        version = "2.0.0";
        sha256 = "6516001fa2f0b4d07fc8ae549b5ac59c8f36ddfbfd8215ede3b56fd3784fa2e7";
    };
    dependencies = [
        eff
    ];
};

bifunctors = compilePackage {
    package = githubSource {
        name = "bifunctors";
        version = "2.0.0";
        sha256 = "9db3849ae18388ddd98ee97d567b0ad76681d7d90a23b86f7d43945e12f7dbbd";
    };
    dependencies = [
        control
        newtype
    ];
};

catenable-lists = compilePackage {
    package = githubSource {
        name = "catenable-lists";
        version = "3.0.1";
        sha256 = "0cc03bdce06e4ff8eb58e8bc9de0e95ad8c70f3f8656dfc9a68f8566126d9cc6";
    };
    dependencies = [
        control
        foldable-traversable
        lists
        tuples
        unfoldable
    ];
};

console = compilePackage {
    package = githubSource {
        name = "console";
        version = "2.0.0";
        sha256 = "d3308366c3c52db8785ad60e95213050297fe7cf954b0a2f45e8d0d726975865";
    };
    dependencies = [
        eff
    ];
};

const = compilePackage {
    package = githubSource {
        name = "const";
        version = "2.0.0";
        sha256 = "39086e2376d8a9d01fb718e407db6c27d5a481970103476d1a1b4a069d040145";
    };
    dependencies = [
        contravariant
        foldable-traversable
    ];
};

contravariant = compilePackage {
    package = githubSource {
        name = "contravariant";
        version = "2.0.0";
        sha256 = "e4a11a3e511da89dcd15250b2ab981f6af436d33a915da389099777a97d8ff83";
    };
    dependencies = [
        either
        monoid
        tuples
    ];
};

control = compilePackage {
    package = githubSource {
        name = "control";
        version = "2.0.0";
        sha256 = "31ed22d80583b810c6a8227eafaa902a95586d50fbd6639e655790642eac3b1f";
    };
    dependencies = [
        prelude
    ];
};

datetime = compilePackage {
    package = githubSource {
        name = "datetime";
        version = "2.0.0";
        sha256 = "e1760e6e842881b7f272dc8041d8439e3185444638baf69264bc1d0f72d5b0b9";
    };
    dependencies = [
        enums
        functions
        generics
        integers
        math
    ];
};

distributive = compilePackage {
    package = githubSource {
        name = "distributive";
        version = "2.0.0";
        sha256 = "d9ac7889550699e0ba61c974f6952b2d8922d42903a286ca69a65d8f92bc8532";
    };
    dependencies = [
        identity
    ];
};

eff = compilePackage {
    package = githubSource {
        name = "eff";
        version = "2.0.0";
        sha256 = "37f062abf2904ccea4478a78f2040d9cb185f295536bd4123e6a6ccc4e2bb14f";
    };
    dependencies = [
        prelude
    ];
};

either = compilePackage {
    package = githubSource {
        name = "either";
        version = "2.0.0";
        sha256 = "30c04761bd37f19a3108fb827aeb42a52b61fa4c5727167a905b5c5cb5b63b01";
    };
    dependencies = [
        foldable-traversable
    ];
};

enums = compilePackage {
    package = githubSource {
        name = "enums";
        version = "2.0.1";
        sha256 = "3600f710d7fe9b2f667fa65e770bc1b2a9991f4ae8d740f0e79fc41082dc2953";
    };
    dependencies = [
        either
        strings
        unfoldable
    ];
};

exceptions = compilePackage {
    package = githubSource {
        name = "exceptions";
        version = "2.0.0";
        sha256 = "4d9076bb7c1627bbb081c2f0b38bf03692a57fa242d0c35d4a59df1bfd48537d";
    };
    dependencies = [
        eff
        either
        maybe
    ];
};

exists = compilePackage {
    package = githubSource {
        name = "exists";
        version = "2.0.0";
        sha256 = "8be8ba318df4fe7eac00ba5d0661aed7cbdd15c3816b541f2d6947d6fe22ea39";
    };
    dependencies = [
        unsafe-coerce
    ];
};

foldable-traversable = compilePackage {
    package = githubSource {
        name = "foldable-traversable";
        version = "2.0.0";
        sha256 = "6e5f22da0b2123b657672c303da023fe15f5666d1584423bf42a25a5cc330428";
    };
    dependencies = [
        bifunctors
        maybe
    ];
};

foreign = compilePackage {
    package = githubSource {
        name = "foreign";
        version = "3.0.1";
        sha256 = "f994b81367f9fd0478fa792a3646f1523be501a1b27f69517fe1b6f177442874";
    };
    dependencies = [
        arrays
        either
        foldable-traversable
        functions
        integers
        lists
        strings
        transformers
    ];
};

free = compilePackage {
    package = githubSource {
        name = "free";
        version = "3.0.1";
        sha256 = "1e375529bfa033bc9dd9f8e586d816d8196cbcd94ba2e98fbaf25cdcf75903eb";
    };
    dependencies = [
        catenable-lists
        exists
        inject
        transformers
        unsafe-coerce
    ];
};

functions = compilePackage {
    package = githubSource {
        name = "functions";
        version = "2.0.0";
        sha256 = "450433ff0bf5bafd771844c5e6e9d2201b69faed60494ca3226e8923fe3d81d4";
    };
    dependencies = [
        prelude
    ];
};

functors = compilePackage {
    package = githubSource {
        name = "functors";
        version = "1.0.0";
        sha256 = "3f00f8944d0c89a9c57263b036173e1d4f1a208cf2fd0c58d44e244fda4b7f0d";
    };
    dependencies = [
        const
        either
    ];
};

generics = compilePackage {
    package = githubSource {
        name = "generics";
        version = "3.1.0";
        sha256 = "6b80a90e92be7ccc1c9d5903de3b82db36b823c627ff2e3ff77c5836cfc27206";
    };
    dependencies = [
        arrays
        either
        identity
        proxy
        strings
    ];
};

generics-rep = compilePackage {
    package = githubSource {
        name = "generics-rep";
        version = "4.0.0";
        sha256 = "a7efa426d1b1c2ed3555e1cc3cff82f70f9a02207b7207987989b595d3e96275";
    };
    dependencies = [
        foldable-traversable
        monoid
        prelude
        symbols
    ];
};

globals = compilePackage {
    package = githubSource {
        name = "globals";
        version = "2.0.0";
        sha256 = "290fbbfb54c07708932e285172c43e7d08fde8796ad56f978b2dc62aeb8e0f2f";
    };
    dependencies = [
    ];
};

graphs = compilePackage {
    package = githubSource {
        name = "graphs";
        version = "2.0.0";
        sha256 = "2455a0448b8f713d6aeb2c40e5c5a4beb6c17a5328bc278edb1b60e36b5e6c16";
    };
    dependencies = [
        catenable-lists
        sets
    ];
};

identity = compilePackage {
    package = githubSource {
        name = "identity";
        version = "2.0.0";
        sha256 = "60828516e975a2415bbd9455b81ad55a650a8e78aed40d1b8abf7ac348e0f268";
    };
    dependencies = [
        foldable-traversable
    ];
};

inject = compilePackage {
    package = githubSource {
        name = "inject";
        version = "3.0.0";
        sha256 = "461cf3311acc07a7f8a5b11a9cb02cfac09fbe89bd1702e36a98eccbd2f0f08e";
    };
    dependencies = [
        functors
    ];
};

integers = compilePackage {
    package = githubSource {
        name = "integers";
        version = "2.1.0";
        sha256 = "e5d967fee20d0b1285cc287be7e2c1115fdc4bb1ef84582eff07c36e51795dc1";
    };
    dependencies = [
        math
        maybe
        partial
    ];
};

invariant = compilePackage {
    package = githubSource {
        name = "invariant";
        version = "2.0.0";
        sha256 = "6bb3033c1f2608cc4233e730bf2e6159a209f3cb8a9aa1c775e82641a8428c97";
    };
    dependencies = [
        prelude
    ];
};

lazy = compilePackage {
    package = githubSource {
        name = "lazy";
        version = "2.0.0";
        sha256 = "a62ab9e46ad5b0e5b94b04c1b632777bfeb5f2bf1174b606db1cd7176d372fc8";
    };
    dependencies = [
        monoid
    ];
};

lists = compilePackage {
    package = githubSource {
        name = "lists";
        version = "3.2.1";
        sha256 = "d1c5a2d9ccc7b40b2683c53329e9adb68d3c3e66871e833b6f6428ecc30daed4";
    };
    dependencies = [
        generics
        lazy
        unfoldable
    ];
};

maps = compilePackage {
    package = githubSource {
        name = "maps";
        version = "2.0.2";
        sha256 = "6fa67ab7fa5762eaf0dce8d26d8b3d44116c129b8de7ce1e96ac6fd3996c9fbd";
    };
    dependencies = [
        arrays
        functions
        lists
        st
    ];
};

math = compilePackage {
    package = githubSource {
        name = "math";
        version = "2.0.0";
        sha256 = "3f31609f7005393af461d472edb45c0e99d70ce669af8474cbbd6105cdbbf4b2";
    };
    dependencies = [
    ];
};

maybe = compilePackage {
    package = githubSource {
        name = "maybe";
        version = "2.0.1";
        sha256 = "3abc1ea441231d3e59eb5f8ae008c27176debb56cad38b84e7dc82d4461cb6f6";
    };
    dependencies = [
        monoid
    ];
};

monoid = compilePackage {
    package = githubSource {
        name = "monoid";
        version = "2.2.0";
        sha256 = "1ed0c1b0aa92f7b15b36ab4fa0ff6571c9bb4215b4394b088ffa035a22e9eaab";
    };
    dependencies = [
        control
        invariant
        newtype
    ];
};

newtype = compilePackage {
    package = githubSource {
        name = "newtype";
        version = "1.1.0";
        sha256 = "df78110814236b1c092ff3404e92131e723d3a5bbf9deed2339f92e699742577";
    };
    dependencies = [
        prelude
    ];
};

nonempty = compilePackage {
    package = githubSource {
        name = "nonempty";
        version = "3.0.0";
        sha256 = "8bb48835d5a64dc305a270471eb976eab5097d746476c8ea936e286e1669578e";
    };
    dependencies = [
        foldable-traversable
    ];
};

orders = compilePackage {
    package = githubSource {
        name = "orders";
        version = "2.0.0";
        sha256 = "c4aedbaa5ed141860b0969bb572edf4188fa974239d795121a3a9dfc3081bdc4";
    };
    dependencies = [
        monoid
    ];
};

parallel = compilePackage {
    package = githubSource {
        name = "parallel";
        version = "2.1.0";
        sha256 = "6384cb320ab70a1a49f9f11da7a38624bddbbff92730afed10fa5151158dde89";
    };
    dependencies = [
        functors
        refs
        transformers
    ];
};

partial = compilePackage {
    package = githubSource {
        name = "partial";
        version = "1.1.2";
        sha256 = "4c15e0f8a4827ebe8e6a8c35eba3c9ded4d4716f7b4ef8b2e5c7fbbe57a8874e";
    };
    dependencies = [
    ];
};

prelude = compilePackage {
    package = githubSource {
        name = "prelude";
        version = "2.1.0";
        sha256 = "c1212a4d0535b4c60637564f41ac2a767a24afe2866a5e8590b0dc179b73b1de";
    };
    dependencies = [
    ];
};

profunctor = compilePackage {
    package = githubSource {
        name = "profunctor";
        version = "2.0.0";
        sha256 = "e3423c4ca7f6b3de8d54953abe0cd1781c3438296ab3ed5f642e705dafc68152";
    };
    dependencies = [
        distributive
        either
        tuples
    ];
};

proxy = compilePackage {
    package = githubSource {
        name = "proxy";
        version = "1.0.0";
        sha256 = "220ef0ff8a74f8aed2fd029e52b92b355980ed1bbe1989acaaa846cb177b00b6";
    };
    dependencies = [
    ];
};

psci-support = compilePackage {
    package = githubSource {
        name = "psci-support";
        version = "2.0.0";
        sha256 = "7102644e5eb3f29ae718244041f4c9a3058bb8221de3685af85a3dd1437479c6";
    };
    dependencies = [
        console
    ];
};

quickcheck = compilePackage {
    package = githubSource {
        name = "quickcheck";
        version = "3.1.1";
        sha256 = "5847144ac8869a09a04c187fda027f6c22c070657bce04cfbea3fbd53cfc1868";
    };
    dependencies = [
        arrays
        console
        either
        exceptions
        lists
        random
        strings
        transformers
    ];
};

random = compilePackage {
    package = githubSource {
        name = "random";
        version = "2.0.0";
        sha256 = "2c53e95939d71d8659386b669751f6187b8d938afee183555cfd1f4e609cbcac";
    };
    dependencies = [
        eff
        integers
        math
    ];
};

refs = compilePackage {
    package = githubSource {
        name = "refs";
        version = "2.0.0";
        sha256 = "f144b45e6997a633d0ad97d6d6f3cb7f96507a091fa9128e57e4c4a89d62aad2";
    };
    dependencies = [
        eff
    ];
};

semirings = compilePackage {
    package = githubSource {
        name = "semirings";
        version = "3.0.0";
        sha256 = "036276080e64572ff579f73d4c32f182aa3167bac42afac7acfe740d6d739410";
    };
    dependencies = [
        lists
    ];
};

sets = compilePackage {
    package = githubSource {
        name = "sets";
        version = "2.0.0";
        sha256 = "44c916a6696fc803ee41a5102c165ea2bc28a7a60c53f67833c363a940c26319";
    };
    dependencies = [
        maps
        tailrec
    ];
};

st = compilePackage {
    package = githubSource {
        name = "st";
        version = "2.0.0";
        sha256 = "e228a03cb3480f3b6c92f17a51ee49442e384a8c5b28b35f54630adc10b71776";
    };
    dependencies = [
        eff
    ];
};

strings = compilePackage {
    package = githubSource {
        name = "strings";
        version = "2.0.2";
        sha256 = "f2cb7367c1169333a56c45c9b8414e6b4075eb15d4fa854c346ec8a875da7df1";
    };
    dependencies = [
        either
        maybe
    ];
};

symbols = compilePackage {
    package = githubSource {
        name = "symbols";
        version = "2.0.0";
        sha256 = "39ad0afaf69d795067c6c3690dfab5d339309f5756fc10fb0f6c2380d415eb61";
    };
    dependencies = [
        prelude
        unsafe-coerce
    ];
};

tailrec = compilePackage {
    package = githubSource {
        name = "tailrec";
        version = "2.0.1";
        sha256 = "753910fc6cd6f5deef41f04019099958156f87b2e8a509764d1d458bf084f4d1";
    };
    dependencies = [
        either
        identity
        partial
        st
    ];
};

transformers = compilePackage {
    package = githubSource {
        name = "transformers";
        version = "2.0.2";
        sha256 = "6c0bef20adff5ca16ea975bdcc6f85653cb2d933dfbb03227f5acd69adf40bbe";
    };
    dependencies = [
        arrays
        distributive
        lazy
        tuples
    ];
};

tuples = compilePackage {
    package = githubSource {
        name = "tuples";
        version = "3.0.0";
        sha256 = "fd0ead38e68075951af5917cf4693773a4243ace8cd478a8c6e728a5d0bb373e";
    };
    dependencies = [
        foldable-traversable
    ];
};

unfoldable = compilePackage {
    package = githubSource {
        name = "unfoldable";
        version = "2.0.0";
        sha256 = "b45faaa35a607ea7abff2ae8ca4c09a33c5d0e790e2b6e6b8568af46189d49b0";
    };
    dependencies = [
        partial
        tuples
    ];
};

unsafe-coerce = compilePackage {
    package = githubSource {
        name = "unsafe-coerce";
        version = "2.0.0";
        sha256 = "b72cad40db46648454c67ad1c9ffdd7620961cfd11ca03707a9ab6029a3d644f";
    };
    dependencies = [
    ];
};

validation = compilePackage {
    package = githubSource {
        name = "validation";
        version = "2.0.0";
        sha256 = "138c0c8b6f42fd95ef6a5c198811a19bfadc7331eb09d60edd17ffd96fc07910";
    };
    dependencies = [
        bifunctors
    ];
};

contrib = rec {

    argonaut = compilePackage {
        package = githubSource {
            name = "argonaut";
            version = "2.0.0";
            sha256 = "bcf15ba1d8d87dfad12ae95f6c7de2b05bf8fab8bdde4973cd5e9542de68841c";
            owner = "purescript-contrib";
        };
        dependencies = [
            argonaut-codecs
            argonaut-core
            argonaut-traversals
        ];
    };

    argonaut-codecs = compilePackage {
        package = githubSource {
            name = "argonaut-codecs";
            version = "2.0.0";
            sha256 = "06984ff4f87b669171ec3b3aa2c2deb6288e1f0eea6831d4107b6221b337aba5";
            owner = "purescript-contrib";
        };
        dependencies = [
            argonaut-core
            generics
            integers
        ];
    };

    argonaut-core = compilePackage {
        package = githubSource {
            name = "argonaut-core";
            version = "2.0.1";
            sha256 = "e565710c626b4304389959eba872b95bcb01213e7879f1efa76b2d2ca82005cc";
            owner = "purescript-contrib";
        };
        dependencies = [
            enums
            functions
            maps
        ];
    };

    argonaut-traversals = compilePackage {
        package = githubSource {
            name = "argonaut-traversals";
            version = "2.0.1";
            sha256 = "7994fbb86913149e0d7b53ecef5c13d7039355a819e5fa595a031e03b27cd74e";
            owner = "purescript-contrib";
        };
        dependencies = [
            argonaut-codecs
            profunctor-lenses
        ];
    };

    arraybuffer-types = compilePackage {
        package = githubSource {
            name = "arraybuffer-types";
            version = "0.2.0";
            sha256 = "8bb19dedd57d33753bbc7817c08599b35c5db7e9826cc1cd6dca66240ab6e3d2";
            owner = "purescript-contrib";
        };
        dependencies = [
        ];
    };

    base = compilePackage {
        package = githubSource {
            name = "base";
            version = "1.0.0";
            sha256 = "159d48dc20b52dfd8872d9b2d2c1a8eecdc26074ff6a4f7b2ffd9913eaa5a348";
            owner = "purescript-contrib";
        };
        dependencies = [
            arrays
            console
            control
            either
            enums
            foldable-traversable
            integers
            lists
            math
            maybe
            monoid
            strings
            tuples
            unfoldable
        ];
    };

    canvas = compilePackage {
        package = githubSource {
            name = "canvas";
            version = "1.0.0";
            sha256 = "42161a69084cce9adb4dfac05f1f7bfb2b3ce53bcb08ef8cc1ab078da4aec48a";
            owner = "purescript-contrib";
        };
        dependencies = [
            arraybuffer-types
            eff
            exceptions
            functions
            maybe
        ];
    };

    colors = compilePackage {
        package = githubSource {
            name = "colors";
            version = "2.1.0";
            sha256 = "7e57dc8f9e1ff4a7f1db4a22597d227063411fd488851b9a737788ec6efe0628";
            owner = "sharkdp";
        };
        dependencies = [
            arrays
            integers
            lists
            partial
            strings
        ];
    };

    coroutines = compilePackage {
        package = githubSource {
            name = "coroutines";
            version = "3.1.0";
            sha256 = "bff06b5e9d4116b1a2e581fe458942489b892e8b8b433fd28e8acb892fa790dd";
            owner = "purescript-contrib";
        };
        dependencies = [
            freet
            parallel
            profunctor
        ];
    };

    dom = compilePackage {
        package = githubSource {
            name = "dom";
            version = "3.3.1";
            sha256 = "dee0e9d127245ee87b686f2bc2d2f19f29a18617493eba801532f0aeb62ddff9";
            owner = "purescript-contrib";
        };
        dependencies = [
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
        ];
    };

    drawing = compilePackage {
        package = githubSource {
            name = "drawing";
            version = "2.1.0";
            sha256 = "df11f18abb9e559cb2817f0cbddc11ffae893ff4fdc509bb6ca88d0279dc5a18";
            owner = "purescript-contrib";
        };
        dependencies = [
            canvas
            colors
            integers
            lists
            math
        ];
    };

    eff-functions = compilePackage {
        package = githubSource {
            name = "eff-functions";
            version = "2.0.0";
            sha256 = "27eca41aa6e6987e9c56e93597af0fe220562e81cbb1e726d5c0a844c395cfc8";
            owner = "hdgarrood";
        };
        dependencies = [
            eff
        ];
    };

    foreign-lens = compilePackage {
        package = githubSource {
            name = "foreign-lens";
            version = "2.0.0";
            sha256 = "09fc2a3c2ecb210afbf9e9de9c5d55a1e9fe1205d80eb3f199514b4811ef1c38";
            owner = "purescript-contrib";
        };
        dependencies = [
            foreign
            profunctor-lenses
        ];
    };

    form-urlencoded = compilePackage {
        package = githubSource {
            name = "form-urlencoded";
            version = "2.0.0";
            sha256 = "7f5c1adb05e8b80386e0150a62bedd03779dbedc26bc78e85cb35bbe804a5a85";
            owner = "purescript-contrib";
        };
        dependencies = [
            generics
            globals
            maybe
            prelude
            strings
            tuples
        ];
    };

    freet = compilePackage {
        package = githubSource {
            name = "freet";
            version = "2.0.1";
            sha256 = "24037fa205d332b4d2b4e91fe802d10e6c1a70e83f0bf61bdd7df6a7154cdf44";
            owner = "purescript-contrib";
        };
        dependencies = [
            console
            control
            exists
            tailrec
            transformers
        ];
    };

    handlebars = compilePackage {
        package = githubSource {
            name = "handlebars";
            version = "1.0.0";
            sha256 = "6b622245a061084480d71ac663990ca0c2fa2279ef11b7f2c94bae58fec4ab5b";
            owner = "purescript-contrib";
        };
        dependencies = [
        ];
    };

    http-methods = compilePackage {
        package = githubSource {
            name = "http-methods";
            version = "2.0.0";
            sha256 = "9ae4f94a9f496e257edb5f60cc8f015b291968568b6e1beb031b425201f75091";
            owner = "purescript-contrib";
        };
        dependencies = [
            generics
        ];
    };

    jquery = compilePackage {
        package = githubSource {
            name = "jquery";
            version = "1.0.0";
            sha256 = "628156ee0cc9385c8b975670b81679ddccb2cce29078eadea4c89ac21a0ce857";
            owner = "purescript-contrib";
        };
        dependencies = [
            dom
            eff
            foreign
        ];
    };

    js-date = compilePackage {
        package = githubSource {
            name = "js-date";
            version = "3.0.0";
            sha256 = "c52a9455a856f6164c4c8a2f843928b6d7411189712681d2cd7a5fbc36f5fc17";
            owner = "purescript-contrib";
        };
        dependencies = [
            datetime
            exceptions
            foreign
            integers
        ];
    };

    js-timers = compilePackage {
        package = githubSource {
            name = "js-timers";
            version = "2.0.0";
            sha256 = "f3a1247b18caf6765e108247f3c3eea7b071d77be851aeae1b75fed2724d6add";
            owner = "purescript-contrib";
        };
        dependencies = [
            eff
        ];
    };

    lens = compilePackage {
        package = githubSource {
            name = "lens";
            version = "2.0.0";
            sha256 = "f002a4d3f3609591b27fb848c0a8a8511ab26d5af5088148ec4153467e6ae8c6";
            owner = "purescript-contrib";
        };
        dependencies = [
            const
            distributive
            profunctor
        ];
    };

    machines = compilePackage {
        package = githubSource {
            name = "machines";
            version = "3.0.0";
            sha256 = "a1ca2ddcbff9363a49f8dd8243a6be6909fc1e6bb10c3081891e2f20adf2a76f";
            owner = "purescript-contrib";
        };
        dependencies = [
            arrays
            eff
            lists
            maybe
            monoid
            profunctor
            tuples
        ];
    };

    media-types = compilePackage {
        package = githubSource {
            name = "media-types";
            version = "2.0.0";
            sha256 = "a1b44d1c33c04cbb8b67d39bf647f66cbd433b5f70706d65cb2e05c03da73e92";
            owner = "purescript-contrib";
        };
        dependencies = [
            generics
        ];
    };

    now = compilePackage {
        package = githubSource {
            name = "now";
            version = "2.0.0";
            sha256 = "7adc9e3e39d10f445ba7504faf19b43c74d47625d0c39695b7e8840fcb094808";
            owner = "purescript-contrib";
        };
        dependencies = [
            datetime
            eff
        ];
    };

    nullable = compilePackage {
        package = githubSource {
            name = "nullable";
            version = "2.0.0";
            sha256 = "cd55633ad15e46c27bfe849c3475f756c73842645712ba70d27a86a8364ced06";
            owner = "purescript-contrib";
        };
        dependencies = [
            functions
            maybe
        ];
    };

    options = compilePackage {
        package = githubSource {
            name = "options";
            version = "2.0.0";
            sha256 = "4b69be5e2f12f530cb01f76aed36fff48c1e2eb77673d87d398bbccf1882dd1e";
            owner = "purescript-contrib";
        };
        dependencies = [
            contravariant
            foreign
            maps
            maybe
            monoid
            tuples
        ];
    };

    parsing = compilePackage {
        package = githubSource {
            name = "parsing";
            version = "3.0.1";
            sha256 = "8ddc26dccab248b21ffdc0f62b16a4c5627121384b1e796b52385ca171d1bac4";
            owner = "purescript-contrib";
        };
        dependencies = [
            arrays
            either
            foldable-traversable
            identity
            integers
            lists
            maybe
            strings
            transformers
            unicode
        ];
    };

    precise = compilePackage {
        package = githubSource {
            name = "precise";
            version = "1.0.1";
            sha256 = "39ba506e472d18cdc909886c87ef62656b29272821a240502715027741fe99b9";
            owner = "purescript-contrib";
        };
        dependencies = [
            arrays
            globals
            integers
            quickcheck
            strings
        ];
    };

    profunctor-lenses = compilePackage {
        package = githubSource {
            name = "profunctor-lenses";
            version = "2.1.0";
            sha256 = "9a546233c3c7e4a967690c4dd8b88303456a209174a7559f2d002850cc696145";
            owner = "purescript-contrib";
        };
        dependencies = [
            const
            functors
            identity
            profunctor
            sets
            transformers
            unsafe-coerce
        ];
    };

    react = compilePackage {
        package = githubSource {
            name = "react";
            version = "1.3.0";
            sha256 = "8dc497b18c71014b3b47df0d65f0eb046dedb071eb2bd87667d87f1d9c315e31";
            owner = "purescript-contrib";
        };
        dependencies = [
            eff
            prelude
            unsafe-coerce
        ];
    };

    react-addons-css-transition-group = compilePackage {
        package = githubSource {
            name = "react-addons-css-transition-group";
            version = "0.2.1";
            sha256 = "5faabc81d1028e9c59aee96f1ba5ecabb38912d61fa5c82b3c7c211de1abaed1";
            owner = "purescript-contrib";
        };
        dependencies = [
            react
        ];
    };

    react-dom = compilePackage {
        package = githubSource {
            name = "react-dom";
            version = "1.0.0";
            sha256 = "f4cc06e6178fe0e6d3f75eefd90d5b88d1dce0d853df4217cc1ca503c65ccd6c";
            owner = "purescript-contrib";
        };
        dependencies = [
            dom
            eff-functions
            react
        ];
    };

    sammy = compilePackage {
        package = githubSource {
            name = "sammy";
            version = "1.0.0";
            sha256 = "f17ce933b9723b6c21db8b3bafd3561dca0c992ea0846f834388f83226783e10";
            owner = "purescript-contrib";
        };
        dependencies = [
            eff
        ];
    };

    string-parsers = compilePackage {
        package = githubSource {
            name = "string-parsers";
            version = "2.0.0";
            sha256 = "40b9d5808f11dc2e8a39c0fb3721ee9b10a10ff70d54a7da608af0f892c26cf1";
            owner = "purescript-contrib";
        };
        dependencies = [
            arrays
            control
            either
            foldable-traversable
            lists
            maybe
            strings
            tailrec
        ];
    };

    strongcheck = compilePackage {
        package = githubSource {
            name = "strongcheck";
            version = "2.0.1";
            sha256 = "a1fdaac9bf5dde483bd13440cf578f44dc205d093606b6f10970642faf9d24bd";
            owner = "purescript-contrib";
        };
        dependencies = [
            arrays
            console
            enums
            exceptions
            free
            machines
            random
        ];
    };

    strongcheck-argonaut = compilePackage {
        package = githubSource {
            name = "strongcheck-argonaut";
            version = "1.0.0";
            sha256 = "08663f3994c2e4680a368501846ddce12e728560042961b36d73b7a0b8cddb0b";
            owner = "purescript-contrib";
        };
        dependencies = [
            argonaut
            strongcheck
        ];
    };

    these = compilePackage {
        package = githubSource {
            name = "these";
            version = "2.0.0";
            sha256 = "14e338acae9aff7b3272e7b7ebac81a6492521d4e6108d13156feae1ed7cc7d5";
            owner = "purescript-contrib";
        };
        dependencies = [
            generics
        ];
    };

    unicode = compilePackage {
        package = githubSource {
            name = "unicode";
            version = "2.0.1";
            sha256 = "1f8039563211ef7518033d02bcd7a4718536e8c521cdb07b883b6c799f96e56e";
            owner = "purescript-contrib";
        };
        dependencies = [
            maybe
            foldable-traversable
            strings
        ];
    };

};

}

let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.15.15-20260528/packages.dhall
        sha256:c38baa6107d7951c8ebae15cbfc706288aeba8cbea3db74af0ad23fda7d77e2e

let additions =
      { svg-parser-halogen =
        { dependencies =
          [ "prelude", "bifunctors", "arrays", "either", "halogen", "svg-parser" ]
        , repo = "https://github.com/rnons/purescript-svg-parser-halogen.git"
        , version = "v2.0.0"
        }
      }

in  upstream // additions

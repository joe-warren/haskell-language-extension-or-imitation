{ name = "halogen-project"
, dependencies =
  [ "arrays"
  , "arrays-extra"
  , "console"
  , "effect"
  , "halogen"
  , "maybe"
  , "prelude"
  , "shuffle"
  , "strings"
  , "svg-parser-halogen"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}

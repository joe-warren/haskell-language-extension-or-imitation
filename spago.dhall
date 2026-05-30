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
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}

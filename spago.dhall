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
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}

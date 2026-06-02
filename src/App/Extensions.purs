module App.Extensions where

import Prelude

import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Data.Array as Array
import Data.Array ((:))
import Data.String as String
import Data.Maybe (Maybe (..))

type Extension = 
    { name :: String
    , description :: HH.PlainHTML
    }

quote :: String -> String
quote s = "“" <> s <> "”"

realExtension :: String -> String -> HH.PlainHTML
realExtension desc url = 
    HH.a 
        [ HP.href url
        , HP.target "_blank"
        ]
        [ parseString <<< quote $ desc
        ]

parseCodeblocks :: String -> HH.PlainHTML
parseCodeblocks s = 
    let arr = String.split (String.Pattern "`") s
        go true arr = case Array.uncons arr of 
            Nothing -> []
            Just v -> Array.cons (HH.text v.head) (go false v.tail)
        go false arr = case Array.uncons arr of
            Nothing -> []
            Just v -> Array.cons (HH.code_ [HH.text v.head]) (go true v.tail)
    in HH.span_ (go true arr)

parseString :: String -> HH.PlainHTML
parseString s =
    let arr = String.split (String.Pattern "\n") s
    in HH.div_ (HH.p_ <<< Array.singleton <<< parseCodeblocks <$> arr)

proposal :: Int -> String -> String -> HH.PlainHTML -> HH.PlainHTML
proposal id name url child = 
    HH.div_ 
        [HH.p_ 
            [ HH.text $ "Mentioned in "
            , HH.a 
                [ HP.href url
                , HP.target "_blank"
                ]
                [ HH.text $ "GHC Proposal " <> show id <> " : "
                , parseCodeblocks name
                ]
            , HH.text "."
            ]
        , child
        ] 

negateExtension :: Extension -> Extension
negateExtension e = 
    { name: "No" <> e.name
    , description: HH.div_ [
        HH.p_ 
            [ HH.text $ "Switches off the extension " 
            , HH.code_ [HH.text e.name]
            , HH.text ", which is defined as:"
            ]
        , HH.p_ [ e.description ]
        ] 
    }



realExtensions :: Array Extension
realExtensions = 
    [ { name :"AllowAmbiguousTypes", description : realExtension
            "Allow the user to write ambiguous types, and the type inference engine to infer them."
            "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/ambiguous_types.html#extension-AllowAmbiguousTypes"
        }
    ,{ name :"ApplicativeDo", description : realExtension 
        "Allow do-notation statements to be desugared via Applicative."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/applicative_do.html#extension-ApplicativeDo"
        }
    ,{ name :"Arrows", description : realExtension "Allow arrow notation (e.g. proc)"
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/arrows.html#extension-Arrows"
    }
    ,{ name :"BangPatterns", description : realExtension "Allow bang pattern syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/strict.html#extension-BangPatterns"
    }
    ,{ name :"BinaryLiterals", description : realExtension "Allow binary literal syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/binary_literals.html#extension-BinaryLiterals"
    }
    ,{ name :"BlockArguments", description : realExtension "Allow do blocks and other constructs as function arguments."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/block_arguments.html#extension-BlockArguments"
    }
    ,{ name :"CApiFFI", description : realExtension "Allow foreign imports to be declared with the capi calling convention."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/ffi.html#extension-CApiFFI"
    }
    ,{ name :"ConstrainedClassMethods", description : realExtension "Allow class methods to have non-empty contexts."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/constrained_class_methods.html#extension-ConstrainedClassMethods"
    }
    ,{ name :"ConstraintKinds", description : realExtension "Allow constraints to be used as types of kind Constraint."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/constraint_kind.html#extension-ConstraintKinds"
    }
    ,{ name :"CPP", description : realExtension "Resolve C preprocessor directives."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/constraint_kind.html#extension-ConstraintKinds"
    }
    ,{ name :"CUSKs", description : realExtension "Detect complete user-supplied kind signatures."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/poly_kinds.html#extension-CUSKs"
    }
    ,{ name :"DataKinds", description : realExtension "Allow use of data constructors in types."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/data_kinds.html#extension-DataKinds"
    }
    ,{ name :"DatatypeContexts", description : realExtension "Allow contexts on data types."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/datatype_contexts.html#extension-DatatypeContexts"
    }
    ,{ name :"DeepSubsumption", description : realExtension "Use GHC's deep subsumption checking."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/rank_polymorphism.html#extension-DeepSubsumption"
    }
    ,{ name :"DefaultSignatures", description : realExtension "Allow default signatures for typeclass methods."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/default_signatures.html#extension-DefaultSignatures"
    }
    ,{ name :"DeriveAnyClass", description : realExtension "Allow deriving syntax to be used for any class."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/derive_any_class.html#extension-DeriveAnyClass"
    }
    ,{ name :"DeriveDataTypeable", description : realExtension "Allow deriving for the Data class."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/deriving_extra.html#extension-DeriveDataTypeable"
    }
    ,{ name :"DeriveFoldable", description : realExtension "Allow deriving for the Foldable class."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/deriving_extra.html#extension-DeriveFoldable"
    }
    ,{ name :"DeriveFunctor", description : realExtension "Allow deriving for the Functor class."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/deriving_extra.html#extension-DeriveFunctor"

    }
    ,{ name :"DeriveGeneric", description : realExtension "Allow deriving of Generic instances."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/generics.html#extension-DeriveGeneric"
    }
    ,{ name :"DeriveLift", description : realExtension "Allow deriving for the Lift class"
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/deriving_extra.html#extension-DeriveLift"
    }
    ,{ name :"DeriveTraversable", description : realExtension "Allow deriving for the Traversable class."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/deriving_extra.html#extension-DeriveTraversable"
    }
    ,{ name :"DerivingStrategies", description : realExtension "Allow use of instance deriving strategies."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/deriving_strategies.html#extension-DerivingStrategies"
    }
    ,{ name :"DerivingVia", description : realExtension "Allow deriving instances via types of the same runtime representation."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/deriving_via.html#extension-DerivingVia"
    }
    ,{ name :"DisambiguateRecordFields", description : realExtension "Automatically disambiguate some record field references."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/disambiguate_record_fields.html#extension-DisambiguateRecordFields"
    }
    ,{ name :"DoAndIfThenElse", description : realExtension "Allow semicolons in if expressions."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/doandifthenelse.html#extension-DoAndIfThenElse"
    }
    ,{ name :"DuplicateRecordFields", description : realExtension "Allow definition of record types with identically-named fields."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/duplicate_record_fields.html#extension-DuplicateRecordFields"
    }
    ,{ name :"EmptyCase", description : realExtension "Allow case expressions with no alternatives."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/empty_case.html#extension-EmptyCase"
    }
    ,{ name :"EmptyDataDecls", description : realExtension "Allow definition of empty data types."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/nullary_types.html#extension-EmptyDataDecls"
    }
    ,{ name :"EmptyDataDeriving", description : realExtension "Allow deriving instances of standard type classes for empty data types."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/empty_data_deriving.html#extension-EmptyDataDeriving"
    }
    ,{ name :"ExistentialQuantification", description : realExtension "Allow existentially quantified type variables in types."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/existential_quantification.html#extension-ExistentialQuantification"
    }
    ,{ name :"ExplicitForAll", description : realExtension "Allow explicit universal quantification."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/explicit_forall.html#extension-ExplicitForAll"
    }
    ,{ name :"ExplicitLevelImports", description : realExtension "Allow explicit level imports in Template Haskell."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/template_haskell.html#extension-ExplicitLevelImports"
    }
    ,{ name :"ExplicitNamespaces", description : realExtension "Allow use of the type and data keywords to specify the namespace of entries in import/export lists and in other contexts."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/explicit_namespaces.html#extension-ExplicitNamespaces"
    }
    ,{ name :"ExtendedDefaultRules", description : realExtension "Use GHCi's extended default rules in a normal module." 
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/ghci.html#extension-ExtendedDefaultRules"
    }
    ,{ name :"ExtendedLiterals", description : realExtension "Allow numeric literal postfix syntax for unboxed integers."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/extended_literals.html#extension-ExtendedLiterals"
    }
    ,{ name :"FieldSelectors", description : realExtension "Make record field selector functions visible in expressions."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/field_selectors.html#extension-FieldSelectors"
    }
    ,{ name :"FlexibleContexts", description : realExtension "Remove some restrictions on class contexts"
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/flexible_contexts.html#extension-FlexibleContexts"
    }
    ,{ name :"FlexibleInstances", description : realExtension "Allow instance heads to mention arbitrary nested types."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/instances.html#extension-FlexibleInstances"
    }
    ,{ name :"ForeignFunctionInterface", description : realExtension "Allow foreign function interface syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/ffi.html#extension-ForeignFunctionInterface"
    }
    ,{ name :"FunctionalDependencies", description : realExtension "Allow functional dependencies to be given on typeclass declarations."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/functional_dependencies.html#extension-FunctionalDependencies"
    }
    ,{ name :"GADTs", description : realExtension "Allow definition of generalised algebraic data types."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/gadt.html#extension-GADTs"
    }
    ,{ name :"GADTSyntax", description : realExtension "Allow generalised algebraic data type syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/gadt_syntax.html#extension-GADTSyntax"
    }
    ,{ name :"GeneralisedNewtypeDeriving", description : realExtension "Allow instances to be derived via newtype deriving."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/newtype_deriving.html#extension-GeneralisedNewtypeDeriving"
    }
    ,{ name : "GHC2021", description : realExtension "Use GHC’s set of default language extensions from 2021"
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/control.html#extension-GHC2021"
    }
    ,{ name : "GHC2024", description : realExtension "Use GHC’s set of default language extensions from 2024"
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/control.html#extension-GHC2024"
    }
    ,{ name :"GHCForeignImportPrim", description : realExtension "Allow prim calling convention. Intended for internal use only."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/ffi.html#extension-GHCForeignImportPrim"
    }
    ,{ name : "Haskell2010", description : realExtension "Use the Haskell 2010 language edition."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/control.html#extension-Haskell2010"
    }
    ,{ name : "Haskell98", description : realExtension "Use the Haskell 98 language edition."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/control.html#extension-Haskell98"
    }
    ,{ name :"HexFloatLiterals", description : realExtension "Allow hexadecimal floating-point literal syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/hex_float_literals.html#extension-HexFloatLiterals"
    }
    ,{ name :"ImplicitParams", description : realExtension "Allow implicit parameter constraints."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/implicit_parameters.html#extension-ImplicitParams"
    }
    ,{ name :"ImplicitPrelude", description : realExtension "Implicitly import Prelude."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/rebindable_syntax.html#extension-ImplicitPrelude"
    }
    ,{ name :"ImplicitStagePersistence", description : realExtension "Allow identifiers to be used at different levels from where they are defined."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/template_haskell.html#extension-ImplicitStagePersistence"
    }
    ,{ name :"ImportQualifiedPost", description : realExtension "Allows the syntax import M qualified"
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/import_qualified_post.html#extension-ImportQualifiedPost"
    }
    ,{ name :"ImpredicativeTypes", description : realExtension "Allow impredicative types."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/impredicative_types.html#extension-ImpredicativeTypes"
    }
    ,{ name :"IncoherentInstances", description : realExtension "Allow definitions of instances that may result in incoherence."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/instances.html#extension-IncoherentInstances"
    }
    ,{ name :"InstanceSigs", description : realExtension "Allow type signatures to be written for instance methods."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/instances.html#extension-InstanceSigs"
    }
    ,{ name :"InterruptibleFFI", description : realExtension "Allow interruptible FFI imports."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/ffi.html#extension-InterruptibleFFI"
    }
    ,{ name :"KindSignatures", description : realExtension "Allow kind signatures to be given for types."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/kind_signatures.html#extension-KindSignatures"
    }
    ,{ name :"LambdaCase", description : realExtension "Allow `\\case` expressions."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/lambda_case.html#extension-LambdaCase"
    }
    ,{ name :"LexicalNegation", description : realExtension "Use whitespace to determine whether the minus sign stands for negation or subtraction."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/lexical_negation.html#extension-LexicalNegation"
    }
    ,{ name :"LiberalTypeSynonyms", description : realExtension "Relax many of Haskell 98's rules on type synonym definitions."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/liberal_type_synonyms.html#extension-LiberalTypeSynonyms"
    }
    ,{ name :"LinearTypes", description : realExtension "Allow writing of linear arrow types. Implies `MonoLocalBinds`."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/linear_types.html#extension-LinearTypes"
    }
    ,{ name :"ListTuplePuns", description : realExtension "Enable punning for list, tuple and sum types."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/data_kinds.html#extension-ListTuplePuns"
    }
    ,{ name :"MagicHash", description : realExtension "Allow # as a postfix modifier on identifiers."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/magic_hash.html#extension-MagicHash"
    }
    ,{ name :"MonadComprehensions", description : realExtension "Allow list comprehension syntax to be used at monads other than List."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/monad_comprehensions.html#extension-MonadComprehensions"
    }
    ,{ name :"MonoLocalBinds", description : realExtension "Do not generalise types of local bindings."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/let_generalisation.html#extension-MonoLocalBinds"
    }
    ,{ name :"MonomorphismRestriction", description : realExtension "Apply the Haskell 2010 monomorphism restriction."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/monomorphism.html#extension-MonomorphismRestriction"
    }
    ,{ name :"MultilineStrings", description : realExtension "Enable multiline string literals."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/multiline_strings.html#extension-MultilineStrings"
    }
    ,{ name :"MultiParamTypeClasses", description : realExtension "Enable multi-parameter type classes."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/multi_param_type_classes.html#extension-MultiParamTypeClasses"
    }
    ,{ name :"MultiWayIf", description : realExtension "Allow multi-way if-expressions."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/multiway_if.html#extension-MultiWayIf"
    }
    ,{ name :"NamedDefaults", description : realExtension "Enable default declarations with explicitly named class, extending Type class defaulting."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/named_defaults.html#extension-NamedDefaults"
    }
    ,{ name :"NamedFieldPuns", description : realExtension "Allow record field punning syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/record_puns.html#extension-NamedFieldPuns"
    }
    ,{ name :"NamedWildCards", description : realExtension "Allow named wildcards in types."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/partial_type_signatures.html#extension-NamedWildCards"
    }
    ,{ name :"NegativeLiterals", description : realExtension "Allow negative numeric literal syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/negative_literals.html#extension-NegativeLiterals"
    }
    ,{ name :"NondecreasingIndentation", description : realExtension "Allow nested contexts to be at the same indentation level as its enclosing context."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/bugs.html#extension-NondecreasingIndentation"
    }
    ,{ name :"NPlusKPatterns", description : realExtension "Allow use of n+k patterns."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/nk_patterns.html#extension-NPlusKPatterns"
    }
    ,{ name :"NullaryTypeClasses", description : realExtension "Deprecated, does nothing. nullary type classes are now enabled using `MultiParamTypeClasses`."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/nullary_type_classes.html#extension-NullaryTypeClasses"
    }
    ,{ name :"NumDecimals", description : realExtension "Allow use of scientific notation syntax for integer literals."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/num_decimals.html#extension-NumDecimals"
    }
    ,{ name :"NumericUnderscores", description : realExtension "Allow underscores in numeric literals."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/numeric_underscores.html#extension-NumericUnderscores"
    }
    ,{ name :"OrPatterns", description : realExtension "Enable or-patterns."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/or_patterns.html#extension-OrPatterns"
    }
    ,{ name :"OverlappingInstances", description : realExtension "Allow definition of overlapping instances."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/instances.html#extension-OverlappingInstances"
    }
    ,{ name :"OverloadedLabels", description : realExtension "Allow overloaded label syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/overloaded_labels.html#extension-OverloadedLabels"
    }
    ,{ name :"OverloadedLists", description : realExtension "Desugar list syntax via the `IsList` class."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/overloaded_lists.html#extension-OverloadedLists"
    }
    ,{ name :"OverloadedRecordDot", description : realExtension "Allow `.` to be used for record field access."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/overloaded_record_dot.html#extension-OverloadedRecordDot"
    }
    ,{ name :"OverloadedRecordUpdate", description : realExtension "Allow `.` syntax in record updates"
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/overloaded_record_update.html#extension-OverloadedRecordUpdate"
    }
    ,{ name :"OverloadedStrings", description : realExtension "Desugar string literals via IsString class."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/overloaded_strings.html#extension-OverloadedStrings"
    }
    ,{ name :"PackageImports", description : realExtension "Allow package-qualified import syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/package_qualified_imports.html#extension-PackageImports"
    }
    ,{ name :"ParallelListComp", description : realExtension "Allow parallel list comprehension syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/parallel_list_comprehensions.html#extension-ParallelListComp"
    }
    ,{ name :"PartialTypeSignatures", description : realExtension "Allow type signatures to contain wildcards."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/partial_type_signatures.html#extension-PartialTypeSignatures"
    }
    ,{ name :"PatternGuards", description : realExtension "Allow pattern guards syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/pattern_guards.html#extension-PatternGuards"
    }
    ,{ name :"PatternSynonyms", description : realExtension "Allow definition of pattern synonyms."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/pattern_synonyms.html#extension-PatternSynonyms"
    }
    ,{ name :"PolyKinds", description : realExtension "Allow kind polymorphism."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/poly_kinds.html#extension-PolyKinds"
    }
    ,{ name :"PostfixOperators", description : realExtension "Allow the use of postfix operators."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/rebindable_syntax.html#extension-PostfixOperators"
    }
    ,{ name :"QualifiedDo", description : realExtension "Allow qualified do-notation desugaring."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/qualified_do.html#extension-QualifiedDo"
    }
    ,{ name :"QualifiedStrings", description : realExtension "Enable qualified string literals."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/qualified_strings.html#extension-QualifiedStrings"
    }
    ,{ name :"QuantifiedConstraints", description : realExtension "Allow forall quantifiers in constraints."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/quantified_constraints.html#extension-QuantifiedConstraints"
    }
    ,{ name :"QuasiQuotes", description : realExtension "Allow quasiquotation syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/template_haskell.html#extension-QuasiQuotes"
    }
    ,{ name :"Rank2Types", description : realExtension "Enable rank-2 types."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/rank_polymorphism.html#extension-Rank2Types"
    }
    ,{ name :"RankNTypes", description : realExtension "Allow types of rank greater than one."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/rank_polymorphism.html#extension-RankNTypes"
    }
    ,{ name :"RebindableSyntax", description : realExtension "Allow rebinding of builtin syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/rebindable_syntax.html#extension-RebindableSyntax"
    }
    ,{ name :"RecordWildCards", description : realExtension "Allow use of record wildcard syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/record_wildcards.html#extension-RecordWildCards"
    }
    ,{ name :"RecursiveDo", description : realExtension "Allow recursive do (e.g. `mdo`) notation."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/recursive_do.html#extension-RecursiveDo"
    }
    ,{ name :"RelaxedPolyRec", description : realExtension "Generalised typing of mutually recursive bindings."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/relaxed_poly_rec.html#extension-RelaxedPolyRec"
    }
    ,{ name :"RequiredTypeArguments", description : realExtension "Allow use of required type argument syntax in terms."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/required_type_arguments.html#extension-RequiredTypeArguments"
    }
    ,{ name :"RoleAnnotations", description : realExtension "Allow role annotation syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/roles.html#extension-RoleAnnotations"
    }
    ,{ name :"Safe", description : realExtension "Enable the Safe Haskell Safe mode."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/safe_haskell.html#extension-Safe"
    }
    ,{ name :"ScopedTypeVariables", description : realExtension "Lexically scoped explicitly-introduced type variables."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/scoped_type_variables.html#extension-ScopedTypeVariables"
    }
    ,{ name :"StandaloneDeriving", description : realExtension "Allow standalone instance deriving declarations."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/standalone_deriving.html#extension-StandaloneDeriving"
    }
    ,{ name :"StandaloneKindSignatures", description : realExtension "Allow standalone kind signature declarations."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/poly_kinds.html#extension-StandaloneKindSignatures"
    }
    ,{ name :"StarIsType", description : realExtension "Treat `*` as Data.Kind.Type."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/poly_kinds.html#extension-StarIsType"
    }
    ,{ name :"StaticPointers", description : realExtension "Allow static syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/static_pointers.html#extension-StaticPointers"
    }
    ,{ name :"Strict", description : realExtension "Make bindings in the current module strict by default."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/strict.html#extension-Strict"
    }
    ,{ name :"StrictData", description : realExtension "Treat datatype fields as strict by default."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/strict.html#extension-StrictData"
    }
    ,{ name :"TemplateHaskell", description : realExtension "Allow Template Haskell's splice and quotation syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/template_haskell.html#extension-TemplateHaskell"
    }
    ,{ name :"TemplateHaskellQuotes", description : realExtension "Allow Template Haskell's quotation syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/template_haskell.html#extension-TemplateHaskellQuotes"
    }
    ,{ name :"TraditionalRecordSyntax", description : realExtension "Allow traditional record syntax (e.g. `C {f = x}`)."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/traditional_record_syntax.html#extension-TraditionalRecordSyntax"
    }
    ,{ name :"TransformListComp", description : realExtension "Allow generalised list comprehension syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/generalised_list_comprehensions.html#extension-TransformListComp"
    }
    ,{ name :"Trustworthy", description : realExtension "Enable the Safe Haskell Trustworthy mode."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/safe_haskell.html#extension-Trustworthy"
    }
    ,{ name :"TupleSections", description : realExtension "Allow use of tuple section synxtax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/tuple_sections.html#extension-TupleSections"
    }
    ,{ name :"TypeAbstractions", description : realExtension "Allow type abstraction syntax in patterns and type variable binders."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/type_abstractions.html#extension-TypeAbstractions"
    }
    ,{ name :"TypeApplications", description : realExtension "Allow type application syntax in terms and types."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/type_applications.html#extension-TypeApplications"
    }
    ,{ name :"TypeData", description : realExtension "Allow type data declarations."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/type_data.html#extension-TypeData"
    }
    ,{ name :"TypeFamilies", description : realExtension "Allow definition of type families."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/type_families.html#extension-TypeFamilies"
    }
    ,{ name :"TypeFamilyDependencies", description : realExtension "Allow injectivity annotations on type families."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/type_families.html#extension-TypeFamilyDependencies"
    }
    ,{ name :"TypeInType", description : realExtension "Deprecated. Enable kind polymorphism and datatype promotion."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/poly_kinds.html#extension-TypeInType"
    }
    ,{ name :"TypeOperators", description : realExtension "Allow type constructors to be given operator names."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/type_operators.html#extension-TypeOperators"
    }
    ,{ name :"TypeSynonymInstances", description : realExtension "Allow type synonyms to be mentioned in instance heads."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/instances.html#extension-TypeSynonymInstances"
    }
    ,{ name :"UnboxedSums", description : realExtension "Allow the use of unboxed sum syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/primitives.html#extension-UnboxedSums"
    }
    ,{ name :"UnboxedTuples", description : realExtension "Allow the use of unboxed tuple syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/primitives.html#extension-UnboxedTuples"
    }
    ,{ name :"UndecidableInstances", description : realExtension "Allow definition of instances which may make solving undecidable."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/instances.html#extension-UndecidableInstances"
    }
    ,{ name :"UndecidableSuperClasses", description : realExtension "Allow all superclass constraints, including those that may result in non-termination of the typechecker." 
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/undecidable_super_classes.html#extension-UndecidableSuperClasses"
    }
    ,{ name :"UnicodeSyntax", description : realExtension "Enable unicode syntax." 
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/unicode_syntax.html#extension-UnicodeSyntax"
    }
    ,{ name :"UnliftedDatatypes", description : realExtension "Allow the definition of unlifted data types."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/primitives.html#extension-UnliftedDatatypes"
     }
    ,{ name :"UnliftedFFITypes", description : realExtension "Allow the types of foreign imports to contain certain unlifted types."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/ffi.html#extension-UnliftedFFITypes"
    }
    ,{ name :"UnliftedNewtypes", description : realExtension "Allow definition of unlifted newtypes."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/primitives.html#extension-UnliftedNewtypes"
    }
    ,{ name :"Unsafe", description : realExtension "Enable Safe Haskell Unsafe mode." 
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/safe_haskell.html#extension-Unsafe"
    }
    ,{ name :"ViewPatterns", description : realExtension "Allow view pattern syntax."
        "https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/view_patterns.html#extension-ViewPatterns"
    }
    ]

submittedBy :: String -> Array HH.PlainHTML -> HH.PlainHTML
submittedBy submitter desc = 
    HH.div_ 
        [ HH.p_ desc
        , HH.p 
            [HP.class_ (HH.ClassName "submittedBy")]
            [HH.text ("submitted by " <> submitter)]
        ]

proposal281 = proposal 281 "Visible `forall` in types of terms, and types in terms" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0281-visible-forall.rst"

proposal282 = proposal 282 "Record Dot Syntax" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0282-record-dot-syntax.rst"

proposal448 = proposal 448 "Modern Scoped Type Variables" "https://github.com/ghc-proposals/ghc-proposals/tree/master/proposals/0448-type-variable-scoping.rst" 

proposal285 = proposal 285 "No Implicit Binds" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0285-no-implicit-binds.rst"

proposal193 = proposal 193 "Make `forall` a keyword" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0193-forall-keyword.rst"

proposal111 = proposal 111 "Linear Types" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0111-linear-types.rst"

proposal302 = proposal 302 "`\\cases` - Multi-way lambda expressions" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0302-cases.rst"

proposal37 = proposal 37 "Hexadecimal Floats in Haskell" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0037-hexFloats.rst"

proposal23 = proposal 23 "Overloaded Record Fields" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0023-overloaded-record-fields.rst"

proposal583 = proposal 583 "HasField redesign" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0583-hasfield-redesign.rst"

proposal409 = proposal 409 "Generalized, named, and exportable `default` declarations" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0409-exportable-named-default.rst"

proposal242 = proposal 242 "Unsaturated Type Families" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0242-unsaturated-type-families.rst"

proposal83 = proposal 83 "Embrace Type :: Type" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0083-no-type-in-type.rst"

proposal143 = proposal 143 "Remove the * kind syntax" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0143-remove-star-kind.rst"

proposal378 = proposal 378 "Design for Dependent Types" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0378-dependent-type-design.rst"

proposal216 = proposal 216 "Qualified do" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0216-qualified-do.rst"

proposal232 = proposal 232 "Ambiguous Type per-signature pragma" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0232-AmbiguousType-pragma.rst"

proposal372 = proposal 372 "The GHC20XX process" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0372-ghc-extensions.rst"

proposal652 = proposal 652 "Import shadowing" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0652-import-shadowing.rst"

proposal631 = proposal 631 "Meaningful main return types" "https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0631-main-return-types.rst"


negateFakeExtension :: Extension -> Extension
negateFakeExtension e = 
    { name: "No" <> e.name
    , description: e.description
    }


fakeExtensions :: Array Extension 
fakeExtensions =
    [ { name: "ApplicativeDon't", description: parseString "It's `ApplicativeDo`" }
    , { name: "MagicCrack", description: parseString "" }
    , { name: "HashtagCoerce", description: parseString "It's a complier plugin" }
    , { name: "ImplicitConversions", description: parseString "It's a Scala compiler flag." }
    , { name: "PostfixOps", description: parseString "`PostfixOperators` is a Haskell language extension.\n`PostfixOps` is a Scala compiler flag" }
    , { name: "Existentials", description: parseString "The extension that allows defining existential datatypes is actually called `ExistentialQuantification`.\n`Existentials` is a Scala compiler flag." }
    , { name: "BetterMonadicFor", description: parseString "It's a Scala compiler plugin." }
    , { name: "ApplicativeComprehensions", description: submittedBy "Reed" []}
    , { name: "UnboxedNewtypes", description: submittedBy "Reed" []}
    , { name: "UnboxedDatatypes", description: submittedBy "Reed" []}
    , { name: "DeriveTypeable", description: submittedBy "Reed" []}
    , { name: "HexLiterals", description: submittedBy "Reed"
            [ HH.p_ [parseString "BinaryLiterals is real, but this isn't"]
            ]
    }
    , { name: "NonDecreasingComplexity", description: submittedBy "edmundnoble" [] }
    , { name: "ArrowSyntax", description: submittedBy "mniip"
            [ HH.p_ [parseString "The extension that enables arrow syntax is actually called `Arrows``."]
            ]
    }
    , { name: "RecordDotSyntax", description: proposal282 $ submittedBy "mniip"
            [ parseString "The extensions comprising record dot syntax are actually called `OverloadedRecordDot` and `OverloadedRecordUpdate.`"
            ]
    }
    , { name: "ExtendedLists", description: submittedBy "mniip" 
        [parseString "The real extensions are:\n`OverloadedLists` for overloading the list literal syntax\n`ParallelListComp` for extending the comprehension syntax with zips\nand `TransformListComp` for extending the comprehension syntax with \"group by\" and arbitrary processing steps."
        ]
    }
    , { name: "InjectiveTypeFamilies", description: submittedBy "mniip" 
        [parseString "The extension that allows specifying injectivity annotations for type families is actually called `TypeFamilyDependencies`."] 
    }
    , { name: "DecreasingIndentation", description:  submittedBy "mniip" 
        [parseString "The extension that relaxes indentation requirements is actually called `NondecreasingIndentation``."
        ]
    }
    , { name: "FlexibleClasses", description:  submittedBy "mniip"
        [ parseString "The extensions that relax requirements on typeclass use are actually called `FlexibleContexts` and `FlexibleInstances`."
        ] 
    }
    , { name: "FlexibleConstraints", description:  submittedBy "mniip" 
        [ parseString "The extensions that relax requirements on typeclass use are actually called `FlexibleContexts` and `FlexibleInstances`."
        ]
    }
    , { name: "UndecidableConstraints", description:  submittedBy "mniip" 
        [parseString "The extension that disables termination checking for constraint resolution is actually called `UndecidableInstances`."
        ]
    }
    , { name: "LiberalInstances", description: submittedBy "mniip"
        [parseString "The real extensions are:\nFlexibleInstances for relaxed rules for instances\n`TypeSynonymInstances` allowing use of type synonyms in instances\nand `LiberalTypeSynonyms` for deferring impredicativity and partial application checks until after type synonyms are expanded."
        ]
    }    
    , { name: "QuantifiedTypes", description: submittedBy "mniip" 
        [ parseString "The extension that enables the forall quantifier in types is `ExplicitForAll` or `RankNTypes`.\nThe extension that enables the forall quantifier in constraints is `QuantifiedConstraints`."
        ]
    } 
    , { name: "QualifiedTypes", description: submittedBy "mniip" 
        [ parseString "There's no such thing as a \"qualified\" type."
        ] } 
    , { name: "UniversalQuantification", description: submittedBy "mniip" 
        [ parseString "The \"universal\" quantifier is the forall quantifier, enabled by `ExplicitForAll` or `RankNTypes`.\nThe extension that allows the use of the forall quantifier in datatype definitions is actually called `ExistentialQuantification`."
        ]
    } 
    , { name: "MultiParamTypeFamilies", description: submittedBy "mniip"
        [ parseString "The real extension is `MultiParamTypeClasses`.\nType families (whenever enabled) can always have multiple parameters."
        ]
    }
    , { name: "NullaryTypeFamilies", description: submittedBy "mniip" 
        [parseString "The real extension is `NullaryTypeClasses`.\nType families (whenever enabled) can always have no arguments."
        ]
    } 
    , { name: "DependentKinds", description: submittedBy "mniip"
        [parseString "Kinding (types of types) is always dependently typed in GHC, though this can only be observed if `PolyKinds` and `DataKinds` are in use."
        ]
    } 
    , { name: "KindOperators", description: submittedBy "mniip" 
        [parseString "The real extension is called `TypeOperators`. Kinds are not distinguished from types and can use operators as well when enabled."
        ] } 
    , { name: "DeriveEq", description: submittedBy "mniip" 
        [ parseString "It is always possible to derive `Eq`.\nReal extensions that cover additional typeclasses are called:\n`DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
        ] } 
    , { name: "DeriveOrd", description: submittedBy "mniip"
        [ parseString "It is always possible to derive Ord.\nReal extensions that cover additional typeclasses are called:\n`DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
        ] } 
    , { name: "DeriveShow", description: submittedBy "mniip"
        [ parseString "It is always possible to derive Show.\nReal extensions that cover additional typeclasses are called:\n`DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
        ] } 
    , { name: "DeriveRead", description: submittedBy "mniip"
        [ parseString "It is always possible to derive Read.\nReal extensions that cover additional typeclasses are called:\n`DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
        ] } 
    , { name: "DeriveEnum", description: submittedBy "mniip"
        [ parseString "It is always possible to derive Enum.\nReal extensions that cover additional typeclasses are called:\n`DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
        ] } 
    , { name: "DeriveBounded", description: submittedBy "mniip" 
        [ parseString "It is always possible to derive Bounded.\nReal extensions that cover additional typeclasses are called:\n`DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
        ] 
    }
    , { name: "DeriveIx", description: submittedBy "mniip" 
        [ parseString "It is always possible to derive Ix.\nReal extensions that cover additional typeclasses are called:\n`DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
        ]
    }
    , { name: "DeriveCoercible", description: submittedBy "mniip" 
        [ parseString "Coercible is a compiler built-in, for which no instances can be defined (nor derived).\nReal typeclass-specific deriving extensions are called:\n`DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
        ] 
    } 
    , { name: "DeriveMonad", description: submittedBy "mniip" 
        [ parseString "A Monad instance cannot be derived based on a datatype's structure.\nReal extensions that do enable deriving for additional typeclasses are called:\n`DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
        ]
    } 
    , { name: "DeriveNewtype", description: submittedBy "mniip" 
        [parseString "The extension that allows deriving instances of most classes for a newtype is actually called `GeneralisedNewtypeDeriving`."
        ]
    } 
    , { name: "UnboxedLiterals", description: submittedBy "mniip" 
        [ parseString "The syntax for literals of unboxed types, such as `1# :: Int#` is actually enabled as part of the `MagicHash` extension."
        ] } 
    , { name: "UnliftedCoercions", description: submittedBy "mniip" 
        [ parseString "GHC can choose to use lifted or unlifted representations for coercions,\nbut the user generally has no control over this."
        ] } 
    , { name: "ListSections", description: submittedBy "mniip" 
        [ parseString "The extension that allows omitting an element of a tuple to create a tupling operator section is called `TupleSections`.\nThere is no analogous extension for lists."
        ] } 
    , { name: "WildcardImports", description: submittedBy "mniip"
        [parseString "A wildcard import (import X rather than import X (x)) is part of `Haskell98` and is always available.\nA similar sounding real extension is `RecordWildCards`."
        ] 
    } 
    , { name: "TypeSynonyms", description: submittedBy "mniip" 
        [ parseString "Type synonyms (`type X = ...`) are part of `Haskell98` and are always available."
        ] } 
    , { name: "ExplicitArguments", description: submittedBy "mniip" 
        [parseString " The extension that allows explicit type-level arguments is actually called `TypeApplications`.\nThe extension that allows making such parameters required is actually called `RequiredTypeArguments`."
        ]
    } 
    , { name: "CompletePatterns", description: submittedBy "mniip" 
        [parseString "`{-# COMPLETE ... #-}` pragmas for pattern synonyms are actually always available whenever `PatternSynonyms` itself is enabled."
    ] } 
    , { name: "RecursiveLet", description: submittedBy "mniip" 
        [parseString "The ability to write (mutually) recursive bindings in a let is part of `Haskell98` and is always enabled."
        ]
    } 
    ,{ name: "OverloadedDecimalDot", description: submittedBy "lexi" [] }
    ,{ name: "StarPatterns", description: submittedBy "lexi" [] }
    ,{ name: "NoForcing", description: submittedBy "lexi" [] }
    ,{ name: "GenerousKinds", description: submittedBy "lexi" [] }
    ,{ name: "Golang", description: submittedBy "lexi" [] }
    ,{ name: "ImportQualifiedInfix", description: submittedBy "lexi" [] }
    ,{ name: "NandPatterns", description: submittedBy "lexi" [] }
    ,{ name: "CoherentInstances", description: submittedBy "lexi" [] }
    ,{ name: "NoLayoutRule", description: submittedBy "lexi" [] }
    ,{ name: "RebindableSemicolons", description: submittedBy "lexi" [] }
    ,{ name: "LambdaIf", description: submittedBy "lexi" [] }
    ,{ name: "NoPolymorphism", description: submittedBy "lexi" [] }
    ,{ name: "LazyData", description: submittedBy "lexi" [] }
    ,{ name: "QuasiBangs", description: submittedBy "lexi" [] }
    ,{ name: "CloseMissingParens", description: submittedBy "lexi" [] }
    ,{ name: "DollarKinds", description: submittedBy "lexi" [] }
    ,{ name: "GGADTs", description: submittedBy "lexi" [] }
    ,{ name: "SanctifiedDo", description: submittedBy "lexi" [] }
    ,{ name: "IncoherentApplication", description: submittedBy "taneb" [] }
    ,{ name: "NoPragmas", description: submittedBy "sshuck" [] }
    ,{ name: "NoStarIsMultiplication", description: submittedBy "taneb" [] }
    ,{ name: "OverloadedBools", description: submittedBy "taneb" [] }
    ,{ name: "UndecidableBools", description: submittedBy "Jappie" [] }
    ,{ name: "Halting", description: submittedBy "lexi" [] }
    ,{ name: "RuntimeImports", description: submittedBy "sshuck" [] }
    ,{ name: "TypeLambdas", description: submittedBy "taneb" [] }
    ,{ name: "GeneralizedNewtypeIntegrating", description: submittedBy "taneb" [] }
    ,{ name: "UndecidableErrorMessages", description: submittedBy "Alice"
        [HH.p_ [parseString "Some people would claim this is on by default."]
        ]
    }
    ,{ name: "NoBetaReduction", description: submittedBy "taneb" [] }
    ,{ name: "ShareAlike", description: submittedBy "lexi" [] }
    ,{ name: "NoAttribution", description: submittedBy "lexi" [] }
    ,{ name: "NonCommercial", description: submittedBy "lexi" [] }
    ,{ name: "DeponentTypes", description: submittedBy "bradrn" [] }
    ,{ name: "UnpredictableTypes", description: submittedBy "lexi" [] }
    ,{ name: "DodgySyntax", description: submittedBy "sshuck" [] }
    ,{ name: "UnsafeCharLits", description: submittedBy "sshuck" [] }
    ,{ name: "NoBottom", description: submittedBy "lexi" [] }
    ,{ name: "NumericPuns", description: submittedBy "sshuck" [] }
    ,{ name: "RecordFieldSynonyms", description: submittedBy "lexi" [] }
    ,{ name: "BestEffortCoercions", description: submittedBy "sshuck" [] }
    ,{ name: "TypeAntonyms", description: submittedBy "Hécate" [] }
    ,{ name: "RankNFile", description: submittedBy "mniip" [] }
    ,{ name: "StrictPolyRec", description: submittedBy "bradrn" []}
    ,{ name: "PolymorphismRestriction", description: submittedBy "bradrn" [] }
    ,{ name: "VisibleForall", description: proposal281 $ submittedBy "Alice"
        [ parseString "The extension called `RequiredTypeArguments` was part of a proposal called `VisibleForall`\n`VisibleForall was proposed as an alternate name"
        ]
    }
    , { name: "RecursiveTypes", description: submittedBy "Alice" []}
    , { name: "ExistentialTypes", description: submittedBy "mniip" 
        [ parseString "The extension that allows defining existential datatypes is actually called `ExistentialQuantification`."
        ]
    }
    , { name: "ImplicitParameters", description: submittedBy "mniip"
        [ parseString "The extension introducing implicit parameters `(?x :: X)` is actually called `ImplicitParams`."
        ]
    } 
    , { name: "ClosedTypeFamilies", description: submittedBy "mniip"
        [ parseString "The ability to write a closed type family (`type family ... where`) is always available whenever `TypeFamilies` are themselves enabled."
        ]
    }
    , { name: "FlexibleSuperClasses", description: submittedBy "mniip" 
        [ parseString "Real extensions that relax requirements on typeclass use are `FlexibleContexts` and `FlexibleInstances`.\nA similar sounding real extension is `UndecidableSuperClasses`."
        ]
    }
    , { name: "UndecidableTypeFamilies", description: submittedBy "mniip"
          [ parseString "Disabling termination checking for type family reduction is actually included in `UndecidableInstances`.\nType family equations are considered \"instances\"."
          ]
    }
    , { name: "LetPolymorphism", description: submittedBy "mniip"
          [ parseString "Writing a polymorphic binding with a type signature in a let is part of `Haskell98` and is always enabled.\nThe extension that controls whether bindings without a type signature automatically become polymorphic is actually called `MonoLocalBinds`."
          ]
    }
    , { name: "PedanticBottoms", description: submittedBy "mniip"
          [ parseString "The optimizer's treatment of bottoms is controlled by a -fpedantic-bottoms flag\nThis can be specified in a `{-# OPTIONS_GHC ... #-}` pragma. It is not a language extension."
          ]
    }
    , { name: "QualifiedIf", description: submittedBy "mniip"
          [ parseString "The extension that allows customizing the implementation of if ... then ... else ... is `RebindableSyntax`.\nThere's no way to qualify which `ifThenElse` is to be used, like you can with the `QualifiedDo` extension."
          ]
    }, { name: "NoIncreasingIndentation", description: submittedBy "Benji"
        [ parseString "`NondecreasingIndentation` is a real languae extension, this isn't"
        ]
    }, { name: "NMinusKPatterns", description: submittedBy "bradrn"
        [ parseString "`NPlusKPatterns` allows the use of `n+k` patterns.\n`n-k` patterns aren't real.\nThey can't hurt you."
        ]
    } 
    , {name: "ExtendedForAllScope", description: proposal448 $
        parseString "Proposed as a standalone extension split out of `ScopedTypeVariables`"
    }
    , {name: "MethodTypeVariables", description: proposal448 $
        parseString "Proposed sub-extension of the `ScopedTypeVariables` breakup; never shipped"
    }
    , {name: "ScopedForAlls", description: proposal448 $
        parseString "Intermediate design name, renamed to `ExtendedForAllScope`, never shipped"
    }
    , {name: "RumpEndOfOldScopedTypeVariables", description: proposal448 $
        parseString "Rhetorical name used to argue against keeping the leftover `ScopedTypeVariables` behavior, never a real extension"
    }
    , {name: "ImplicitForAll", description: proposal285 $
        parseString "Proposed sub-extension never shipped"
    }
    , {name: "PatternSignatureBinds", description: proposal285 $
        parseString "Proposed sub-extension (with `NoPatternSignatureBinds`), never shipped"
    }
    , {name: "ImplicitBinds", description: proposal285 $
        parseString "Strawman combined name floated in `Alternatives`, never shipped"
    }
    , {name: "KeywordForall", description: proposal193 $
        parseString "Alternative 'hide behind an extension' option, rejected (forall became a keyword unconditionally)"
    }
    , {name: "LinearArrows", description: proposal111 $
        parseString "Rejected alternative name, shipped as `LinearTypes`"
    }
    , {name: "LinearFunctions", description: proposal111 $
        parseString "Rejected alternative name, shipped as `LinearTypes`"
    }
    , {name: "LinearFunctionTypes", description: proposal111 $
        parseString "Rejected alternative name, shipped as `LinearTypes`"
    }
    , {name: "LinearityKind", description: proposal111 $
        parseString "Speculative name for a notional future extension, never shipped"
    }
    , {name: "LambdaCases", description: proposal302 $
        parseString "Proposed alternative new extension, `LambdaCase` was extended instead"
    }
    , {name: "ExtendedCase", description: proposal302 $
        parseString "Proposed as alternative design, never shipped"
    }
    , {name: "HexadecimalFloats", description: proposal37 $
        parseString "Proposed extension name, shipped as `HexFloatLiterals`"
    }
    , {name: "OverloadedRecordFields", description: proposal23 $
        parseString "Proposed umbrella extension, never shipped under this name (functionality split into `HasField`/`DuplicateRecordFields`)"
    }
    , {name: "MaybeFieldSelectors", description: proposal583 $
        parseString "Suggested extension; never shipped"
    }
    , {name: "ImportedDefaults", description: proposal409 $
        parseString "Originally a separate extension in this proposal, dropped before acceptance"
    }
    , {name: "UnsaturatedTypeFamilies", description: proposal242 $
        parseString "Accepted experimentally but never released"
    }
    , {name: "TypeColonOperators", description: proposal83 $
        parseString "Proposed in `Alternatives`, not pursued"
    }
    , {name: "DependentHaskell", description: proposal143 $
        parseString "Aspirational future-direction flag, never shipped"
    }
    , {name: "DependentTypes", description: proposal378 $
        parseString "Aspirational opt-in flag in a design sketch, never shipped"
    }
    , {name: "OverloadedDo", description: proposal216 $
        parseString "`QualifiedDo` shipped instead"
    }
    , {name: "AmbiguousTypesPragma", description: proposal232 $
        parseString "Floated as a module-wide -X form of the `{-# AMBIGUOUS #-}` pragma, accepted but not implemented as of writing"
    }
    , {name: "ExtendedTypeClasses", description: proposal372 $
        parseString "Illustrative name for a hypothetical single extension bundling `MultiParamTypeClasses` and `FlexibleInstances`, never a real extension"
    }
    , {name: "ImportShadowing", description: proposal652 $
        parseString "Accepted (2024/08/15) but not implemented as of writing"
    }
    , { name: "MeaningfulMainReturn", description: proposal631 $
        parseString "Accepted (2024-05-21) but not implemented as of writing"
    }
    ]
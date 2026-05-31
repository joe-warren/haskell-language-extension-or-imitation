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

quote :: HH.PlainHTML -> HH.PlainHTML
quote s = HH.span_ [HH.text "“", s, HH.text "”"]

quote' = quote <<< parseString 

parseString :: String -> HH.PlainHTML
parseString s = 
    let arr = String.split (String.Pattern "`") s
        go true arr = case Array.uncons arr of 
            Nothing -> []
            Just v -> Array.cons (HH.text v.head) (go false v.tail)
        go false arr = case Array.uncons arr of
            Nothing -> []
            Just v -> Array.cons (HH.code_ [HH.text v.head]) (go true v.tail)
    in HH.span_ (go true arr)

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
                , parseString name
                ]
            , HH.text "."
            ]
        , HH.p_ [child]
        ] 



realExtensions :: Array Extension
realExtensions = 
    [ { name :"AllowAmbiguousTypes", description : quote' "Allow the user to write ambiguous types, and the type inference engine to infer them."}
    ,{ name :"ApplicativeDo", description : quote' "Allow do-notation statements to be desugared via Applicative."}
    ,{ name :"Arrows", description : quote' "Allow arrow notation (e.g. proc)"}
    ,{ name :"BangPatterns", description : quote' "Allow bang pattern syntax."}
    ,{ name :"BinaryLiterals", description : quote' "Allow binary literal syntax."}
    ,{ name :"BlockArguments", description : quote' "Allow do blocks and other constructs as function arguments."}
    ,{ name :"CApiFFI", description : quote' "Allow foreign imports to be declared with the capi calling convention."}
    ,{ name :"ConstrainedClassMethods", description : quote' "Allow class methods to have non-empty contexts."}
    ,{ name :"ConstraintKinds", description : quote' "Allow constraints to be used as types of kind Constraint."}
    ,{ name :"CPP", description : quote' "Resolve C preprocessor directives."}
    ,{ name :"CUSKs", description : quote' "Detect complete user-supplied kind signatures."}
    ,{ name :"DataKinds", description : quote' "Allow use of data constructors in types."}
    ,{ name :"DatatypeContexts", description : quote' "Allow contexts on data types."}
    ,{ name :"DeepSubsumption", description : quote' "Use GHC's deep subsumption checking."}
    ,{ name :"DefaultSignatures", description : quote' "Allow default signatures for typeclass methods."}
    ,{ name :"DeriveAnyClass", description : quote' "Allow deriving syntax to be used for any class."}
    ,{ name :"DeriveDataTypeable", description : quote' "Allow deriving for the Data class."}
    ,{ name :"DeriveFoldable", description : quote' "Allow deriving for the Foldable class."}
    ,{ name :"DeriveFunctor", description : quote' "Allow deriving for the Functor class."}
    ,{ name :"DeriveGeneric", description : quote' "Allow deriving of Generic instances."}
    ,{ name :"DeriveLift", description : quote' "Allow deriving for the Lift class"}
    ,{ name :"DeriveTraversable", description : quote' "Allow deriving for the Traversable class."}
    ,{ name :"DerivingStrategies", description : quote' "Allow use of instance deriving strategies."}
    ,{ name :"DerivingVia", description : quote' "Allow deriving instances via types of the same runtime representation."}
    ,{ name :"DisambiguateRecordFields", description : quote' "Automatically disambiguate some record field references."}
    ,{ name :"DoAndIfThenElse", description : quote' "Allow semicolons in if expressions."}
    ,{ name :"DuplicateRecordFields", description : quote' "Allow definition of record types with identically-named fields."}
    ,{ name :"EmptyCase", description : quote' "Allow case expressions with no alternatives."}
    ,{ name :"EmptyDataDecls", description : quote' "Allow definition of empty data types."}
    ,{ name :"EmptyDataDeriving", description : quote' "Allow deriving instances of standard type classes for empty data types."}
    ,{ name :"ExistentialQuantification", description : quote' "Allow existentially quantified type variables in types."}
    ,{ name :"ExplicitForAll", description : quote' "Allow explicit universal quantification."}
    ,{ name :"ExplicitLevelImports", description : quote' "Allow explicit level imports in Template Haskell."}
    ,{ name :"ExplicitNamespaces", description : quote' "Allow use of the type and data keywords to specify the namespace of entries in import/export lists and in other contexts."}
    ,{ name :"ExtendedDefaultRules", description : quote' "Use GHCi's extended default rules in a normal module."}
    ,{ name :"ExtendedLiterals", description : quote' "Allow numeric literal postfix syntax for unboxed integers."}
    ,{ name :"FieldSelectors", description : quote' "Make record field selector functions visible in expressions."}
    ,{ name :"FlexibleContexts", description : quote' "Remove some restrictions on class contexts"}
    ,{ name :"FlexibleInstances", description : quote' "Allow instance heads to mention arbitrary nested types."}
    ,{ name :"ForeignFunctionInterface", description : quote' "Allow foreign function interface syntax."}
    ,{ name :"FunctionalDependencies", description : quote' "Allow functional dependencies to be given on typeclass declarations."}
    ,{ name :"GADTs", description : quote' "Allow definition of generalised algebraic data types."}
    ,{ name :"GADTSyntax", description : quote' "Allow generalised algebraic data type syntax."}
    ,{ name :"GeneralisedNewtypeDeriving", description : quote' "Allow instances to be derived via newtype deriving."}
    ,{ name : "GHC2021", description : quote' "Use GHC’s set of default language extensions from 2021"}
    ,{ name : "GHC2024", description : quote' "Use GHC’s set of default language extensions from 2024"}
    ,{ name :"GHCForeignImportPrim", description : quote' "Allow prim calling convention. Intended for internal use only."}
    ,{ name : "Haskell2010", description : quote' "Use the Haskell 2010 language edition."}
    ,{ name : "Haskell98", description : quote' "Use the Haskell 98 language edition."}
    ,{ name :"HexFloatLiterals", description : quote' "Allow hexadecimal floating-point literal syntax."}
    ,{ name :"ImplicitParams", description : quote' "Allow implicit parameter constraints."}
    ,{ name :"ImplicitPrelude", description : quote' "Implicitly import Prelude."}
    ,{ name :"ImplicitStagePersistence", description : quote' "Allow identifiers to be used at different levels from where they are defined."}
    ,{ name :"ImportQualifiedPost", description : quote' "Allows the syntax import M qualified"}
    ,{ name :"ImpredicativeTypes", description : quote' "Allow impredicative types."}
    ,{ name :"IncoherentInstances", description : quote' "Allow definitions of instances that may result in incoherence."}
    ,{ name :"InstanceSigs", description : quote' "Allow type signatures to be written for instance methods."}
    ,{ name :"InterruptibleFFI", description : quote' "Allow interruptible FFI imports."}
    ,{ name :"KindSignatures", description : quote' "Allow kind signatures to be given for types."}
    ,{ name :"LambdaCase", description : quote' "Allow `\\case` expressions."}
    ,{ name :"LexicalNegation", description : quote' "Use whitespace to determine whether the minus sign stands for negation or subtraction."}
    ,{ name :"LiberalTypeSynonyms", description : quote' "Relax many of Haskell 98's rules on type synonym definitions."}
    ,{ name :"LinearTypes", description : quote' "Allow writing of linear arrow types. Implies `MonoLocalBinds`."}
    ,{ name :"ListTuplePuns", description : quote' "Enable punning for list, tuple and sum types."}
    ,{ name :"MagicHash", description : quote' "Allow # as a postfix modifier on identifiers."}
    ,{ name :"MonadComprehensions", description : quote' "Allow list comprehension syntax to be used at monads other than List."}
    ,{ name :"MonoLocalBinds", description : quote' "Do not generalise types of local bindings."}
    ,{ name :"MonomorphismRestriction", description : quote' "Apply the Haskell 2010 monomorphism restriction."}
    ,{ name :"MultilineStrings", description : quote' "Enable multiline string literals."}
    ,{ name :"MultiParamTypeClasses", description : quote' "Enable multi-parameter type classes."}
    ,{ name :"MultiWayIf", description : quote' "Allow multi-way if-expressions."}
    ,{ name :"NamedDefaults", description : quote' "Enable default declarations with explicitly named class, extending Type class defaulting."}
    ,{ name :"NamedFieldPuns", description : quote' "Allow record field punning syntax."}
    ,{ name :"NamedWildCards", description : quote' "Allow named wildcards in types."}
    ,{ name :"NegativeLiterals", description : quote' "Allow negative numeric literal syntax."}
    ,{ name :"NondecreasingIndentation", description : quote' "Allow nested contexts to be at the same indentation level as its enclosing context."}
    ,{ name :"NPlusKPatterns", description : quote' "Allow use of n+k patterns."}
    ,{ name :"NullaryTypeClasses", description : quote' "Deprecated, does nothing. nullary type classes are now enabled using `MultiParamTypeClasses`."}
    ,{ name :"NumDecimals", description : quote' "Allow use of scientific notation syntax for integer literals."}
    ,{ name :"NumericUnderscores", description : quote' "Allow underscores in numeric literals."}
    ,{ name :"OrPatterns", description : quote' "Enable or-patterns."}
    ,{ name :"OverlappingInstances", description : quote' "Allow definition of overlapping instances."}
    ,{ name :"OverloadedLabels", description : quote' "Allow overloaded label syntax."}
    ,{ name :"OverloadedLists", description : quote' "Desugar list syntax via the `IsList` class."}
    ,{ name :"OverloadedRecordDot", description : quote' "Allow `.` to be used for record field access."}
    ,{ name :"OverloadedRecordUpdate", description : quote' "Allow `.` syntax in record updates"}
    ,{ name :"OverloadedStrings", description : quote' "Desugar string literals via IsString class."}
    ,{ name :"PackageImports", description : quote' "Allow package-qualified import syntax."}
    ,{ name :"ParallelListComp", description : quote' "Allow parallel list comprehension syntax."}
    ,{ name :"PartialTypeSignatures", description : quote' "Allow type signatures to contain wildcards."}
    ,{ name :"PatternGuards", description : quote' "Allow pattern guards syntax."}
    ,{ name :"PatternSynonyms", description : quote' "Allow definition of pattern synonyms."}
    ,{ name :"PolyKinds", description : quote' "Allow kind polymorphism."}
    ,{ name :"PostfixOperators", description : quote' "Allow the use of postfix operators."}
    ,{ name :"QualifiedDo", description : quote' "Allow qualified do-notation desugaring."}
    ,{ name :"QualifiedStrings", description : quote' "Enable qualified string literals."}
    ,{ name :"QuantifiedConstraints", description : quote' "Allow forall quantifiers in constraints."}
    ,{ name :"QuasiQuotes", description : quote' "Allow quasiquotation syntax."}
    ,{ name :"Rank2Types", description : quote' "Enable rank-2 types."}
    ,{ name :"RankNTypes", description : quote' "Allow types of rank greater than one."}
    ,{ name :"RebindableSyntax", description : quote' "Allow rebinding of builtin syntax."}
    ,{ name :"RecordWildCards", description : quote' "Allow use of record wildcard syntax."}
    ,{ name :"RecursiveDo", description : quote' "Allow recursive do (e.g. `mdo`) notation."}
    ,{ name :"RelaxedPolyRec", description : quote' "Generalised typing of mutually recursive bindings."}
    ,{ name :"RequiredTypeArguments", description : quote' "Allow use of required type argument syntax in terms."}
    ,{ name :"RoleAnnotations", description : quote' "Allow role annotation syntax."}
    ,{ name :"Safe", description : quote' "Enable the Safe Haskell Safe mode."}
    ,{ name :"ScopedTypeVariables", description : quote' "Lexically scoped explicitly-introduced type variables."}
    ,{ name :"StandaloneDeriving", description : quote' "Allow standalone instance deriving declarations."}
    ,{ name :"StandaloneKindSignatures", description : quote' "Allow standalone kind signature declarations."}
    ,{ name :"StarIsType", description : quote' "Treat `*` as Data.Kind.Type."}
    ,{ name :"StaticPointers", description : quote' "Allow static syntax."}
    ,{ name :"Strict", description : quote' "Make bindings in the current module strict by default."}
    ,{ name :"StrictData", description : quote' "Treat datatype fields as strict by default."}
    ,{ name :"TemplateHaskell", description : quote' "Allow Template Haskell's splice and quotation syntax."}
    ,{ name :"TemplateHaskellQuotes", description : quote' "Allow Template Haskell's quotation syntax."}
    ,{ name :"TraditionalRecordSyntax", description : quote' "Allow traditional record syntax (e.g. `C {f = x}`)."}
    ,{ name :"TransformListComp", description : quote' "Allow generalised list comprehension syntax."}
    ,{ name :"Trustworthy", description : quote' "Enable the Safe Haskell Trustworthy mode."}
    ,{ name :"TupleSections", description : quote' "Allow use of tuple section synxtax."}
    ,{ name :"TypeAbstractions", description : quote' "Allow type abstraction syntax in patterns and type variable binders."}
    ,{ name :"TypeApplications", description : quote' "Allow type application syntax in terms and types."}
    ,{ name :"TypeData", description : quote' "Allow type data declarations."}
    ,{ name :"TypeFamilies", description : quote' "Allow definition of type families."}
    ,{ name :"TypeFamilyDependencies", description : quote' "Allow injectivity annotations on type families."}
    ,{ name :"TypeInType", description : quote' "Deprecated. Enable kind polymorphism and datatype promotion."}
    ,{ name :"TypeOperators", description : quote' "Allow type constructors to be given operator names."}
    ,{ name :"TypeSynonymInstances", description : quote' "Allow type synonyms to be mentioned in instance heads."}
    ,{ name :"UnboxedSums", description : quote' "Allow the use of unboxed sum syntax."}
    ,{ name :"UnboxedTuples", description : quote' "Allow the use of unboxed tuple syntax."}
    ,{ name :"UndecidableInstances", description : quote' "Allow definition of instances which may make solving undecidable."}
    ,{ name :"UndecidableSuperClasses", description : quote' "Allow all superclass constraints, including those that may result in non-termination of the typechecker." }
    ,{ name :"UnicodeSyntax", description : quote' "Enable unicode syntax." }
    ,{ name :"UnliftedDatatypes", description : quote' "Allow the definition of unlifted data types." }
    ,{ name :"UnliftedFFITypes", description : quote' "Allow the types of foreign imports to contain certain unlifted types." }
    ,{ name :"UnliftedNewtypes", description : quote' "Allow definition of unlifted newtypes."}
    ,{ name :"Unsafe", description : quote' "Enable Safe Haskell Unsafe mode." }
    ,{ name :"ViewPatterns", description : quote' "Allow view pattern syntax." }
    ]

submittedBy :: String -> Array HH.PlainHTML -> HH.PlainHTML
submittedBy submitter desc = HH.div_ [HH.p_ desc, HH.p_ [HH.text ("submitted by " <> submitter)]]

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

fakeExtensions :: Array Extension 
fakeExtensions =
    [ { name: "ApplicativeDon't", description: parseString "It's `ApplicativeDo`" }
    , { name: "MagicCrack", description: parseString "You're probably thinking of `MagicHash`" }
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
            [ HH.p_ [parseString "The extension that enables arrow syntax is actually called`Arrows``."]
            ]
    }
    , { name: "RecordDotSyntax", description: proposal282 $ submittedBy "mniip"
            [ parseString "The extensions comprising record dot syntax are actually called `OverloadedRecordDot` and `OverloadedRecordUpdate.`"
            ]
    }
    , { name: "ExtendedLists", description: submittedBy "mniip" 
        [parseString "The real extensions are: `OverloadedLists` for overloading the list literal syntax, `ParallelListComp` for extending the comprehension syntax with zips, and `TransformListComp` for extending the comprehension syntax with \"group by\" and arbitrary processing steps."
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
        [parseString "The real extensions are: FlexibleInstances for relaxed rules for instances, `TypeSynonymInstances` allowing use of type synonyms in instances, and `LiberalTypeSynonyms` for deferring impredicativity and partial application checks until after type synonyms are expanded."
        ]
    }    
    , { name: "QuantifiedTypes", description: submittedBy "mniip" 
        [ parseString "The extension that enables the forall quantifier in types is `ExplicitForAll` or `RankNTypes`. The extension that enables the forall quantifier in constraints is `QuantifiedConstraints`."
        ]
    } 
    , { name: "QualifiedTypes", description: submittedBy "mniip" 
        [ parseString "There's no such thing as a \"qualified\" type."
        ] } 
    , { name: "UniversalQuantification", description: submittedBy "mniip" 
        [ parseString "The \"universal\" quantifier is the forall quantifier, enabled by `ExplicitForAll` or `RankNTypes`. The extension that allows the use of the forall quantifier in datatype definitions is actually called `ExistentialQuantification`."
        ]
    } 
    , { name: "MultiParamTypeFamilies", description: submittedBy "mniip"
        [ parseString "The real extension is `MultiParamTypeClasses`. Type families (whenever enabled) can always have multiple parameters."
        ]
    }
    , { name: "NullaryTypeFamilies", description: submittedBy "mniip" 
        [parseString "The real extension is `NullaryTypeClasses`. Type families (whenever enabled) can always have no arguments."
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
        [ parseString "It is always possible to derive `Eq`. Real extensions that cover additional typeclasses are called: `DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
        ] } 
    , { name: "DeriveOrd", description: submittedBy "mniip"
        [ parseString "It is always possible to derive Ord. Real extensions that cover additional typeclasses are called: `DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
        ] } 
    , { name: "DeriveShow", description: submittedBy "mniip"
        [ parseString "It is always possible to derive Show. Real extensions that cover additional typeclasses are called: `DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
        ] } 
    , { name: "DeriveRead", description: submittedBy "mniip"
        [ parseString "It is always possible to derive Read. Real extensions that cover additional typeclasses are called: `DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
        ] } 
    , { name: "DeriveEnum", description: submittedBy "mniip"
        [ parseString "It is always possible to derive Enum. Real extensions that cover additional typeclasses are called: `DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
        ] } 
    , { name: "DeriveBounded", description: submittedBy "mniip" 
        [ parseString "It is always possible to derive Bounded. Real extensions that cover additional typeclasses are called: `DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
        ] 
    }
    , { name: "DeriveIx", description: submittedBy "mniip" 
        [ parseString "It is always possible to derive Ix. Real extensions that cover additional typeclasses are called: `DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
        ]
    }
    , { name: "DeriveCoercible", description: submittedBy "mniip" 
        [ parseString "Coercible is a compiler built-in, for which no instances can be defined (nor derived). Real typeclass-specific deriving extensions are called: `DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
        ] 
    } 
    , { name: "DeriveMonad", description: submittedBy "mniip" 
        [ parseString "A Monad instance cannot be derived based on a datatype's structure. Real extensions that do enable deriving for additional typeclasses are called: `DeriveGeneric`, `DeriveFunctor`, `DeriveFoldable`, `DeriveTraversable`, `DeriveLift`, and `DeriveDataTypeable`."
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
        [ parseString "GHC can choose to use lifted or unlifted representations for coercions, but the user generally has no control over this."
        ] } 
    , { name: "ListSections", description: submittedBy "mniip" 
        [ parseString "The extension that allows omitting an element of a tuple to create a tupling operator section is called `TupleSections`. There is no analogous extension for lists."
        ] } 
    , { name: "WildcardImports", description: submittedBy "mniip"
        [parseString "A wildcard import (import X rather than import X (x)) is part of `Haskell98` and is always available. A similar sounding real extension is `RecordWildCards`."
        ] 
    } 
    , { name: "TypeSynonyms", description: submittedBy "mniip" 
        [ parseString "Type synonyms (`type X = ...`) are part of `Haskell98` and are always available."
        ] } 
    , { name: "ExplicitArguments", description: submittedBy "mniip" 
        [parseString " The extension that allows explicit type-level arguments is actually called `TypeApplications`. The extension that allows making such parameters required is actually called `RequiredTypeArguments`."
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
        [ parseString "The extension called `RequiredTypeArguments` was part of a proposal called `VisibleForall`, `VisibleForall was proposed as an alternate name"
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
        [ parseString "Real extensions that relax requirements on typeclass use are `FlexibleContexts` and `FlexibleInstances`. A similar sounding real extension is `UndecidableSuperClasses`."
        ]
    }
    , { name: "UndecidableTypeFamilies", description: submittedBy "mniip"
          [ parseString "Disabling termination checking for type family reduction is actually included in `UndecidableInstances`. Type family equations are considered \"instances\"."
          ]
    }
    , { name: "LetPolymorphism", description: submittedBy "mniip"
          [ parseString "Writing a polymorphic binding with a type signature in a let is part of `Haskell98` and is always enabled. The extension that controls whether bindings without a type signature automatically become polymorphic is actually called `MonoLocalBinds`."
          ]
    }
    , { name: "PedanticBottoms", description: submittedBy "mniip"
          [ parseString "The optimizer's treatment of bottoms is controlled by a -fpedantic-bottoms flag, which can be specified in a `{-# OPTIONS_GHC ... #-}` pragma. It is not a language extension."
          ]
    }
    , { name: "QualifiedIf", description: submittedBy "mniip"
          [ parseString "The extension that allows customizing the implementation of if ... then ... else ... is `RebindableSyntax`. There's no way to qualify which `ifThenElse` is to be used, like you can with the `QualifiedDo` extension."
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
        parseString "Rejectedalternative name; shipped as `LinearTypes`"
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
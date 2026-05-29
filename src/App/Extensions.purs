module App.Extensions where

import Prelude

import Halogen.HTML as HH
import Data.Array as Array

type Extension = 
    { name :: String
    , description :: HH.PlainHTML
    }

realExtensions :: Array Extension
realExtensions = 
    [ { name :"AllowAmbiguousTypes", description : HH.text "Allow the user to write ambiguous types, and the type inference engine to infer them."}
    ,{ name :"ApplicativeDo", description : HH.text "Allow do-notation statements to be desugared via Applicative."}
    ,{ name :"Arrows", description : HH.text "Allow arrow notation (e.g. proc)"}
    ,{ name :"BangPatterns", description : HH.text "Allow bang pattern syntax."}
    ,{ name :"BinaryLiterals", description : HH.text "Allow binary literal syntax."}
    ,{ name :"BlockArguments", description : HH.text "Allow do blocks and other constructs as function arguments."}
    ,{ name :"CApiFFI", description : HH.text "Allow foreign imports to be declared with the capi calling convention."}
    ,{ name :"ConstrainedClassMethods", description : HH.text "Allow class methods to have non-empty contexts."}
    ,{ name :"ConstraintKinds", description : HH.text "Allow constraints to be used as types of kind Constraint."}
    ,{ name :"CPP", description : HH.text "Resolve C preprocessor directives."}
    ,{ name :"CUSKs", description : HH.text "Detect complete user-supplied kind signatures."}
    ,{ name :"DataKinds", description : HH.text "Allow use of data constructors in types."}
    ,{ name :"DatatypeContexts", description : HH.text "Allow contexts on data types."}
    ,{ name :"DeepSubsumption", description : HH.text "Use GHC's deep subsumption checking."}
    ,{ name :"DefaultSignatures", description : HH.text "Allow default signatures for typeclass methods."}
    ,{ name :"DeriveAnyClass", description : HH.text "Allow deriving syntax to be used for any class."}
    ,{ name :"DeriveDataTypeable", description : HH.text "Allow deriving for the Data class."}
    ,{ name :"DeriveFoldable", description : HH.text "Allow deriving for the Foldable class."}
    ,{ name :"DeriveFunctor", description : HH.text "Allow deriving for the Functor class."}
    ,{ name :"DeriveGeneric", description : HH.text "Allow deriving of Generic instances."}
    ,{ name :"DeriveLift", description : HH.text "Allow deriving for the Lift class"}
    ,{ name :"DeriveTraversable", description : HH.text "Allow deriving for the Traversable class."}
    ,{ name :"DerivingStrategies", description : HH.text "Allow use of instance deriving strategies."}
    ,{ name :"DerivingVia", description : HH.text "Allow deriving instances via types of the same runtime representation."}
    ,{ name :"DisambiguateRecordFields", description : HH.text "Automatically disambiguate some record field references."}
    ,{ name :"DoAndIfThenElse", description : HH.text "Allow semicolons in if expressions."}
    ,{ name :"DuplicateRecordFields", description : HH.text "Allow definition of record types with identically-named fields."}
    ,{ name :"EmptyCase", description : HH.text "Allow case expressions with no alternatives."}
    ,{ name :"EmptyDataDecls", description : HH.text "Allow definition of empty data types."}
    ,{ name :"EmptyDataDeriving", description : HH.text "Allow deriving instances of standard type classes for empty data types."}
    ,{ name :"ExistentialQuantification", description : HH.text "Allow existentially quantified type variables in types."}
    ,{ name :"ExplicitForAll", description : HH.text "Allow explicit universal quantification."}
    ,{ name :"ExplicitLevelImports", description : HH.text "Allow explicit level imports in Template Haskell."}
    ,{ name :"ExplicitNamespaces", description : HH.text "Allow use of the type and data keywords to specify the namespace of entries in import/export lists and in other contexts."}
    ,{ name :"ExtendedDefaultRules", description : HH.text "Use GHCi's extended default rules in a normal module."}
    ,{ name :"ExtendedLiterals", description : HH.text "Allow numeric literal postfix syntax for unboxed integers."}
    ,{ name :"FieldSelectors", description : HH.text "Make record field selector functions visible in expressions."}
    ,{ name :"FlexibleContexts", description : HH.text "Remove some restrictions on class contexts"}
    ,{ name :"FlexibleInstances", description : HH.text "Allow instance heads to mention arbitrary nested types."}
    ,{ name :"ForeignFunctionInterface", description : HH.text "Allow foreign function interface syntax."}
    ,{ name :"FunctionalDependencies", description : HH.text "Allow functional dependencies to be given on typeclass declarations."}
    ,{ name :"GADTs", description : HH.text "Allow definition of generalised algebraic data types."}
    ,{ name :"GADTSyntax", description : HH.text "Allow generalised algebraic data type syntax."}
    ,{ name :"GeneralisedNewtypeDeriving", description : HH.text "Allow instances to be derived via newtype deriving."}
    ,{ name : "GHC2021", description : HH.text "Use GHC’s set of default language extensions from 2021"}
    ,{ name : "GHC2024", description : HH.text "Use GHC’s set of default language extensions from 2024"}
    ,{ name :"GHCForeignImportPrim", description : HH.text "Allow prim calling convention. Intended for internal use only."}
    ,{ name : "Haskell2010", description : HH.text "Use the Haskell 2010 language edition."}
    ,{ name : "Haskell98", description : HH.text "Use the Haskell 98 language edition."}
    ,{ name :"HexFloatLiterals", description : HH.text "Allow hexadecimal floating-point literal syntax."}
    ,{ name :"ImplicitParams", description : HH.text "Allow implicit parameter constraints."}
    ,{ name :"ImplicitPrelude", description : HH.text "Implicitly import Prelude."}
    ,{ name :"ImplicitStagePersistence", description : HH.text "Allow identifiers to be used at different levels from where they are defined."}
    ,{ name :"ImportQualifiedPost", description : HH.text "Allows the syntax import M qualified"}
    ,{ name :"ImpredicativeTypes", description : HH.text "Allow impredicative types."}
    ,{ name :"IncoherentInstances", description : HH.text "Allow definitions of instances that may result in incoherence."}
    ,{ name :"InstanceSigs", description : HH.text "Allow type signatures to be written for instance methods."}
    ,{ name :"InterruptibleFFI", description : HH.text "Allow interruptible FFI imports."}
    ,{ name :"KindSignatures", description : HH.text "Allow kind signatures to be given for types."}
    ,{ name :"LambdaCase", description : HH.text "Allow \\case expressions."}
    ,{ name :"LexicalNegation", description : HH.text "Use whitespace to determine whether the minus sign stands for negation or subtraction."}
    ,{ name :"LiberalTypeSynonyms", description : HH.text "Relax many of Haskell 98's rules on type synonym definitions."}
    ,{ name :"LinearTypes", description : HH.text "Allow writing of linear arrow types. Implies MonoLocalBinds."}
    ,{ name :"ListTuplePuns", description : HH.text "Enable punning for list, tuple and sum types."}
    ,{ name :"MagicHash", description : HH.text "Allow # as a postfix modifier on identifiers."}
    ,{ name :"MonadComprehensions", description : HH.text "Allow list comprehension syntax to be used at monads other than List."}
    ,{ name :"MonoLocalBinds", description : HH.text "Do not generalise types of local bindings."}
    ,{ name :"MonomorphismRestriction", description : HH.text "Apply the Haskell 2010 monomorphism restriction."}
    ,{ name :"MultilineStrings", description : HH.text "Enable multiline string literals."}
    ,{ name :"MultiParamTypeClasses", description : HH.text "Enable multi-parameter type classes."}
    ,{ name :"MultiWayIf", description : HH.text "Allow multi-way if-expressions."}
    ,{ name :"NamedDefaults", description : HH.text "Enable default declarations with explicitly named class, extending Type class defaulting."}
    ,{ name :"NamedFieldPuns", description : HH.text "Allow record field punning syntax."}
    ,{ name :"NamedWildCards", description : HH.text "Allow named wildcards in types."}
    ,{ name :"NegativeLiterals", description : HH.text "Allow negative numeric literal syntax."}
    ,{ name :"NondecreasingIndentation", description : HH.text "Allow nested contexts to be at the same indentation level as its enclosing context."}
    ,{ name :"NPlusKPatterns", description : HH.text "Allow use of n+k patterns."}
    ,{ name :"NullaryTypeClasses", description : HH.text "Deprecated, does nothing. nullary type classes are now enabled using MultiParamTypeClasses."}
    ,{ name :"NumDecimals", description : HH.text "Allow use of scientific notation syntax for integer literals."}
    ,{ name :"NumericUnderscores", description : HH.text "Allow underscores in numeric literals."}
    ,{ name :"OrPatterns", description : HH.text "Enable or-patterns."}
    ,{ name :"OverlappingInstances", description : HH.text "Allow definition of overlapping instances."}
    ,{ name :"OverloadedLabels", description : HH.text "Allow overloaded label syntax."}
    ,{ name :"OverloadedLists", description : HH.text "Desugar list syntax via the IsList class."}
    ,{ name :"OverloadedRecordDot", description : HH.text "Allow . to be used for record field access."}
    ,{ name :"OverloadedRecordUpdate", description : HH.text "Allow . syntax in record updates"}
    ,{ name :"OverloadedStrings", description : HH.text "Desugar string literals via IsString class."}
    ,{ name :"PackageImports", description : HH.text "Allow package-qualified import syntax."}
    ,{ name :"ParallelListComp", description : HH.text "Allow parallel list comprehension syntax."}
    ,{ name :"PartialTypeSignatures", description : HH.text "Allow type signatures to contain wildcards."}
    ,{ name :"PatternGuards", description : HH.text "Allow pattern guards syntax."}
    ,{ name :"PatternSynonyms", description : HH.text "Allow definition of pattern synonyms."}
    ,{ name :"PolyKinds", description : HH.text "Allow kind polymorphism."}
    ,{ name :"PostfixOperators", description : HH.text "Allow the use of postfix operators."}
    ,{ name :"QualifiedDo", description : HH.text "Allow qualified do-notation desugaring."}
    ,{ name :"QualifiedStrings", description : HH.text "Enable qualified string literals."}
    ,{ name :"QuantifiedConstraints", description : HH.text "Allow forall quantifiers in constraints."}
    ,{ name :"QuasiQuotes", description : HH.text "Allow quasiquotation syntax."}
    ,{ name :"Rank2Types", description : HH.text "Enable rank-2 types."}
    ,{ name :"RankNTypes", description : HH.text "Allow types of rank greater than one."}
    ,{ name :"RebindableSyntax", description : HH.text "Allow rebinding of builtin syntax."}
    ,{ name :"RecordWildCards", description : HH.text "Allow use of record wildcard syntax."}
    ,{ name :"RecursiveDo", description : HH.text "Allow recursive do (e.g. mdo) notation."}
    ,{ name :"RelaxedPolyRec", description : HH.text "Generalised typing of mutually recursive bindings."}
    ,{ name :"RequiredTypeArguments", description : HH.text "Allow use of required type argument syntax in terms."}
    ,{ name :"RoleAnnotations", description : HH.text "Allow role annotation syntax."}
    ,{ name :"Safe", description : HH.text "Enable the Safe Haskell Safe mode."}
    ,{ name :"ScopedTypeVariables", description : HH.text "Lexically scoped explicitly-introduced type variables."}
    ,{ name :"StandaloneDeriving", description : HH.text "Allow standalone instance deriving declarations."}
    ,{ name :"StandaloneKindSignatures", description : HH.text "Allow standalone kind signature declarations."}
    ,{ name :"StarIsType", description : HH.text "Treat * as Data.Kind.Type."}
    ,{ name :"StaticPointers", description : HH.text "Allow static syntax."}
    ,{ name :"Strict", description : HH.text "Make bindings in the current module strict by default."}
    ,{ name :"StrictData", description : HH.text "Treat datatype fields as strict by default."}
    ,{ name :"TemplateHaskell", description : HH.text "Allow Template Haskell's splice and quotation syntax."}
    ,{ name :"TemplateHaskellQuotes", description : HH.text "Allow Template Haskell's quotation syntax."}
    ,{ name :"TraditionalRecordSyntax", description : HH.text "Allow traditional record syntax (e.g. C {f : x})."}
    ,{ name :"TransformListComp", description : HH.text "Allow generalised list comprehension syntax."}
    ,{ name :"Trustworthy", description : HH.text "Enable the Safe Haskell Trustworthy mode."}
    ,{ name :"TupleSections", description : HH.text "Allow use of tuple section synxtax."}
    ,{ name :"TypeAbstractions", description : HH.text "Allow type abstraction syntax in patterns and type variable binders."}
    ,{ name :"TypeApplications", description : HH.text "Allow type application syntax in terms and types."}
    ,{ name :"TypeData", description : HH.text "Allow type data declarations."}
    ,{ name :"TypeFamilies", description : HH.text "Allow definition of type families."}
    ,{ name :"TypeFamilyDependencies", description : HH.text "Allow injectivity annotations on type families."}
    ,{ name :"TypeInType", description : HH.text "Deprecated. Enable kind polymorphism and datatype promotion."}
    ,{ name :"TypeOperators", description : HH.text "Allow type constructors to be given operator names."}
    ,{ name :"TypeSynonymInstances", description : HH.text "Allow type synonyms to be mentioned in instance heads."}
    ,{ name :"UnboxedSums", description : HH.text "Allow the use of unboxed sum syntax."}
    ,{ name :"UnboxedTuples", description : HH.text "Allow the use of unboxed tuple syntax."}
    ,{ name :"UndecidableInstances", description : HH.text "Allow definition of instances which may make solving undecidable."}
    ,{ name :"UndecidableSuperClasses", description : HH.text "Allow all superclass constraints, including those that may result in non-termination of the typechecker." }
    ,{ name :"UnicodeSyntax", description : HH.text "Enable unicode syntax." }
    ,{ name :"UnliftedDatatypes", description : HH.text "Allow the definition of unlifted data types." }
    ,{ name :"UnliftedFFITypes", description : HH.text "Allow the types of foreign imports to contain certain unlifted types." }
    ,{ name :"UnliftedNewtypes", description : HH.text "Allow definition of unlifted newtypes."}
    ,{ name :"Unsafe", description : HH.text "Enable Safe Haskell Unsafe mode." }
    ,{ name :"ViewPatterns", description : HH.text "Allow view pattern syntax." }
    ]

submittedBy :: String -> Array HH.PlainHTML -> HH.PlainHTML
submittedBy submitter desc = HH.div_ [HH.p_ desc, HH.p_ [HH.text ("submitted by " <> submitter)]]

fakeExtensions :: Array Extension 
fakeExtensions =
    [ { name: "ApplicativeDon't", description: HH.text "It's ApplicativeDo" }
    , { name: "MagicCrack", description: HH.text "You're probably thinking of MagicHash" }
    , { name: "ApplicativeComprehensions", description: submittedBy "Reed" []}
    , { name: "UnboxedNewtypes", description: submittedBy "Reed" []}
    , { name: "UnboxedDatatypes", description: submittedBy "Reed" []}
    , { name: "DeriveTypeable", description: submittedBy "Reed" []}
    , { name: "HexLiterals", description: submittedBy "Reed"
            [ HH.p_ [HH.text "BinaryLiterals is real, but this isn't"]
            ]
    }
    , { name: "NonDecreasingComplexity", description: submittedBy "edmundnoble" [] }
    , { name: "ArrowSyntax", description: submittedBy "mniip"
            [ HH.p_ [HH.text "The extension that enables arrow syntax is actually called Arrows."]
            ]
    }
    , { name: "RecordDotSyntax", description: submittedBy "mniip"
            [ HH.text "The extensions comprising record dot syntax are actually called OverloadedRecordDot and OverloadedRecordUpdate."
            ]
    }
    , { name: "ExtendedLists", description: submittedBy "mniip" 
        [HH.text "The real extensions are: OverloadedLists for overloading the list literal syntax, ParallelListComp for extending the comprehension syntax with zips, and TransformListComp for extending the comprehension syntax with \"group by\" and arbitrary processing steps."
        ]
    }
    , { name: "InjectiveTypeFamilies", description: submittedBy "mniip" 
        [HH.text "The extension that allows specifying injectivity annotations for type families is actually called TypeFamilyDependencies."] 
    }
    , { name: "DecreasingIndentation", description:  submittedBy "mniip" 
        [HH.text "The extension that relaxes indentation requirements is actually called NondecreasingIndentation."
        ]
    }
    , { name: "FlexibleClasses", description:  submittedBy "mniip"
        [ HH.text "The extensions that relax requirements on typeclass use are actually called FlexibleContexts and FlexibleInstances."
        ] 
    }
    , { name: "FlexibleConstraints", description:  submittedBy "mniip" 
        [ HH.text "The extensions that relax requirements on typeclass use are actually called FlexibleContexts and FlexibleInstances."
        ]
    }
    , { name: "UndecidableConstraints", description:  submittedBy "mniip" 
        [HH.text "The extension that disables termination checking for constraint resolution is actually called UndecidableInstances."
        ]
    }
    , { name: "LiberalInstances", description: submittedBy "mniip"
        [HH.text "The real extensions are: FlexibleInstances for relaxed rules for instances, TypeSynonymInstances allowing use of type synonyms in instances, and LiberalTypeSynonyms for deferring impredicativity and partial application checks until after type synonyms are expanded."
        ]
    }    
    , { name: "QuantifiedTypes", description: submittedBy "mniip" 
        [ HH.text "The extension that enables the forall quantifier in types is ExplicitForAll or RankNTypes. The extension that enables the forall quantifier in constraints is QuantifiedConstraints."
        ]
    } 
    , { name: "QualifiedTypes", description: submittedBy "mniip" 
        [ HH.text "There's no such thing as a \"qualified\" type."
        ] } 
    , { name: "UniversalQuantification", description: submittedBy "mniip" 
        [ HH.text "The \"universal\" quantifier is the forall quantifier, enabled by ExplicitForAll or RankNTypes. The extension that allows the use of the forall quantifier in datatype definitions is actually called ExistentialQuantification."
        ]
    } 
    , { name: "MultiParamTypeFamilies", description: submittedBy "mniip"
        [ HH.text "The real extension is MultiParamTypeClasses. Type families (whenever enabled) can always have multiple parameters."
        ]
    }
    , { name: "NullaryTypeFamilies", description: submittedBy "mniip" 
        [HH.text "The real extension is NullaryTypeClasses. Type families (whenever enabled) can always have no arguments."
        ]
    } 
    , { name: "DependentKinds", description: submittedBy "mniip"
        [HH.text "Kinding (types of types) is always dependently typed in GHC, though this can only be observed if PolyKinds and DataKinds are in use."
        ]
    } 
    , { name: "KindOperators", description: submittedBy "mniip" 
        [HH.text "The real extension is called TypeOperators. Kinds are not distinguished from types and can use operators as well when enabled."
        ] } 
    , { name: "DeriveEq", description: submittedBy "mniip" 
        [ HH.text "It is always possible to derive Eq. Real extensions that cover additional typeclasses are called: DeriveGeneric, DeriveFunctor, DeriveFoldable, DeriveTraversable, DeriveLift, and DeriveDataTypeable."
        ] } 
    , { name: "DeriveOrd", description: submittedBy "mniip"
        [ HH.text "It is always possible to derive Ord. Real extensions that cover additional typeclasses are called: DeriveGeneric, DeriveFunctor, DeriveFoldable, DeriveTraversable, DeriveLift, and DeriveDataTypeable."
        ] } 
    , { name: "DeriveShow", description: submittedBy "mniip"
        [ HH.text "It is always possible to derive Show. Real extensions that cover additional typeclasses are called: DeriveGeneric, DeriveFunctor, DeriveFoldable, DeriveTraversable, DeriveLift, and DeriveDataTypeable."
        ] } 
    , { name: "DeriveRead", description: submittedBy "mniip"
        [ HH.text "It is always possible to derive Read. Real extensions that cover additional typeclasses are called: DeriveGeneric, DeriveFunctor, DeriveFoldable, DeriveTraversable, DeriveLift, and DeriveDataTypeable."
        ] } 
    , { name: "DeriveEnum", description: submittedBy "mniip"
        [ HH.text "It is always possible to derive Enum. Real extensions that cover additional typeclasses are called: DeriveGeneric, DeriveFunctor, DeriveFoldable, DeriveTraversable, DeriveLift, and DeriveDataTypeable."
        ] } 
    , { name: "DeriveBounded", description: submittedBy "mniip" 
        [ HH.text "It is always possible to derive Bounded. Real extensions that cover additional typeclasses are called: DeriveGeneric, DeriveFunctor, DeriveFoldable, DeriveTraversable, DeriveLift, and DeriveDataTypeable."
        ] 
    }
    , { name: "DeriveIx", description: submittedBy "mniip" 
        [ HH.text "It is always possible to derive Ix. Real extensions that cover additional typeclasses are called: DeriveGeneric, DeriveFunctor, DeriveFoldable, DeriveTraversable, DeriveLift, and DeriveDataTypeable."
        ]
    }
    , { name: "DeriveCoercible", description: submittedBy "mniip" 
        [ HH.text "Coercible is a compiler built-in, for which no instances can be defined (nor derived). Real typeclass-specific deriving extensions are called: DeriveGeneric, DeriveFunctor, DeriveFoldable, DeriveTraversable, DeriveLift, and DeriveDataTypeable."
        ] 
    } 
    , { name: "DeriveMonad", description: submittedBy "mniip" 
        [ HH.text "A Monad instance cannot be derived based on a datatype's structure. Real extensions that do enable deriving for additional typeclasses are called: DeriveGeneric, DeriveFunctor, DeriveFoldable, DeriveTraversable, DeriveLift, and DeriveDataTypeable."
        ]
    } 
    , { name: "DeriveNewtype", description: submittedBy "mniip" 
        [HH.text "The extension that allows deriving instances of most classes for a newtype is actually called GeneralisedNewtypeDeriving."
        ]
    } 
    , { name: "UnboxedLiterals", description: submittedBy "mniip" 
        [ HH.text "The syntax for literals of unboxed types, such as 1# :: Int# is actually enabled as part of the MagicHash extension."
        ] } 
    , { name: "UnliftedCoercions", description: submittedBy "mniip" 
        [ HH.text "GHC can choose to use lifted or unlifted representations for coercions, but the user generally has no control over this."
        ] } 
    , { name: "ListSections", description: submittedBy "mniip" 
        [ HH.text "The extension that allows omitting an element of a tuple to create a tupling operator section is called TupleSections. There is no analogous extension for lists."
        ] } 
    , { name: "WildcardImports", description: submittedBy "mniip"
        [HH.text "A wildcard import (import X rather than import X (x)) is part of Haskell98 and is always available. A similar sounding real extension is RecordWildCards."
        ] 
    } 
    , { name: "TypeSynonyms", description: submittedBy "mniip" 
        [ HH.text "Type synonyms type X = ... are part of Haskell98 and are always available."
        ] } 
    , { name: "ExplicitArguments", description: submittedBy "mniip" 
        [HH.text " The extension that allows explicit type-level arguments is actually called TypeApplications. The extension that allows making such parameters required is actually called RequiredTypeArguments."
        ]
    } 
    , { name: "CompletePatterns", description: submittedBy "mniip" 
        [HH.text "{-# COMPLETE ... #-} pragmas for pattern synonyms are actually always available whenever PatternSynonyms itself is enabled."
    ] } 
    , { name: "RecursiveLet", description: submittedBy "mniip" 
        [HH.text "The ability to write (mutually) recursive bindings in a let is part of Haskell98 and is always enabled."
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
        [HH.p_ [HH.text "Some people would claim this is on by default."]
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
    ,{ name: "VisibleForall", description: submittedBy "Alice"
        [ HH.text "The extension called `RequiredTypeArguments` was part of a proposal called `VisibleForall`"
        ]
    }
    , { name: "RecursiveTypes", description: submittedBy "Alice" []}
    , { name: "ExistentialTypes", description: submittedBy "mniip" 
        [ HH.text "The extension that allows defining existential datatypes is actually called ExistentialQuantification."
        ]
    }
    , { name: "ImplicitParameters", description: submittedBy "mniip"
        [ HH.text "The extension introducing implicit parameters (?x :: X) is actually called ImplicitParams."
        ]
    } 
    , { name: "ClosedTypeFamilies", description: submittedBy "mniip"
        [ HH.text "The ability to write a closed type family (type family ... where) is always available whenever TypeFamilies are themselves enabled."
        ]
    }
    , { name: "FlexibleSuperClasses", description: submittedBy "mniip" 
        [ HH.text "Real extensions that relax requirements on typeclass use are FlexibleContexts and FlexibleInstances. A similar sounding real extension is UndecidableSuperClasses."
        ]
    }
    , { name: "UndecidableTypeFamilies", description: submittedBy "mniip"
          [ HH.text "Disabling termination checking for type family reduction is actually included in UndecidableInstances. Type family equations are considered \"instances\"."
          ]
    }
    , { name: "LetPolymorphism", description: submittedBy "mniip"
          [ HH.text "Writing a polymorphic binding with a type signature in a let is part of Haskell98 and is always enabled. The extension that controls whether bindings without a type signature automatically become polymorphic is actually called MonoLocalBinds."
          ]
    }
    , { name: "PedanticBottoms", description: submittedBy "mniip"
          [ HH.text "The optimizer's treatment of bottoms is controlled by a -fpedantic-bottoms flag, which can be specified in a {-# OPTIONS_GHC ... #-} pragma. It is not a language extension."
          ]
    }
    , { name: "QualifiedIf", description: submittedBy "mniip"
          [ HH.text "The extension that allows customizing the implementation of if ... then ... else ... is RebindableSyntax. There's no way to qualify which ifThenElse is to be used, like you can with the QualifiedDo extension."
          ]
    }
    ]
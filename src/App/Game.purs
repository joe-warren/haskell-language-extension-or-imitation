module App.Game where

import Prelude
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Halogen.HTML.Events as HE
import App.Extensions
import App.Svg as Svg
import Data.Array as Array
import Data.String as String
import Effect (Effect)
import Effect.Shuffle (shuffle, pickOr)
import Data.Array.Extra.Unsafe (unsafeHead)
import Data.Maybe (Maybe (Just, Nothing))
import Effect.Class (class MonadEffect, liftEffect)
import Web.URL as URL
import Web.URL.URLSearchParams as URLParams

data Answer = Real | Fake 

derive instance Eq Answer

type Question = 
    { correctAnswer :: Answer
    , extension :: Extension
    , colour :: String
    }

goodQuestion :: String -> Extension -> Question
goodQuestion col e = {correctAnswer: Real, extension: e, colour: col}

badQuestion :: String -> Extension -> Question
badQuestion col e = {correctAnswer: Fake, extension: e, colour: col}

type AnsweredQuestion = 
    { givenAnswer :: Answer
    , message :: String
    , question :: Question
    }

isCorrect :: AnsweredQuestion -> Boolean
isCorrect aq = aq.givenAnswer == aq.question.correctAnswer

data Action
  = NextQuestion
  | GiveAnswer Answer 
  | NewGame

data CurrentView = ToAnswer Question | Answered AnsweredQuestion

type CurrentGame = 
    { answeredQuestions :: Array AnsweredQuestion
    , currentView :: CurrentView
    , upcomingQuestions :: Array Question
    }

data State
  = Playing CurrentGame | Results (Array AnsweredQuestion)

initializeGameState :: Effect State
initializeGameState = do
    randomColours <- shuffle colours 
    good <- Array.zipWith goodQuestion randomColours <<< Array.take 6 <$> shuffle realExtensions
    bad <- Array.zipWith badQuestion (Array.drop 6 randomColours) <<< Array.take 6 <$> shuffle fakeExtensions
    questions <- shuffle (Array.concat [good, bad])
    pure $ Playing 
        { answeredQuestions: []
        , currentView: ToAnswer (unsafeHead questions)
        , upcomingQuestions: Array.drop 1 questions
        }


colours :: Array String
colours = 
    ["red"
    , "green"
    , "blue"
    , "brown"
    , "orange"
    , "yellow"
    , "pink"
    , "purple"
    , "cyan"
    , "lime"
    , "white"
    , "black"]

mkComponent :: forall q i o m. MonadEffect m => Effect (H.Component q i o m)
mkComponent = do
    st <- initializeGameState
    pure $ H.mkComponent
        { initialState: \_ -> st
        , render
        , eval: H.mkEval H.defaultEval { handleAction = handleAction }
        }

resultsText :: Array AnsweredQuestion -> String
resultsText res = 
    let nRounds = Array.length res
        score = Array.length <<< Array.filter isCorrect $ res
    in show score <> " / " <> show nRounds

renderResults :: forall cs m. Array AnsweredQuestion -> H.ComponentHTML Action cs m
renderResults res = 
    HH.div_ 
        [ title
        , iconsForResults res
        , HH.h2_ [ HH.text "Game Over" ]
        , HH.p_ 
            [ HH.text $ "You Scored " <> resultsText res
            ]
        , sharingLinkMastodon res 
        , sharingLinkBsky res 
        , HH.p [HP.class_ (HH.ClassName "buttons")]
            [ HH.button
                [ HE.onClick \_ -> NewGame ]
                [ HH.text "Play Again?" ]
            ]
        ]

iconForAnswered :: forall r i p. AnsweredQuestion -> Array (HH.IProp r i) -> HH.HTML p i
iconForAnswered q = 
    let addColour s = HH.span [HP.class_ (HH.ClassName q.question.colour)] [s]
    in  addColour <<<
        (case [q.givenAnswer, q.question.correctAnswer] of
            [Real, Real] -> Svg.amongusThumbsupIcon 
            [Fake, Fake] -> Svg.amongusImpostorIcon 
            _ -> Svg.amongusDeadIcon
        )

iconForQuestion :: forall r i p.Question -> Array (HH.IProp r i) -> HH.HTML p i
iconForQuestion q = 
    let addColour s = HH.span [HP.class_ (HH.ClassName q.colour)] [s]
    in addColour <<< Svg.amongusDefaultIcon

iconForCurrentView :: forall r i p. CurrentView -> Array (HH.IProp r i) -> HH.HTML p i
iconForCurrentView (ToAnswer q) = iconForQuestion q
iconForCurrentView (Answered q) = iconForAnswered q


iconsForResults :: forall a b. Array AnsweredQuestion -> HH.HTML a b
iconsForResults questions = 
    let mkSmallIcon s = HH.span [HP.class_ (HH.ClassName "smallicon")] [s []]
    in HH.p [HP.class_ $ HH.ClassName "icons"] $
        (mkSmallIcon <<< iconForAnswered <$> questions)

icons :: forall a b. CurrentGame -> HH.HTML a b
icons g = 
    let mkSmallIcon s = HH.span [HP.class_ (HH.ClassName "smallicon")] [s []]
        mkLargeIcon s = HH.span [HP.class_ (HH.ClassName "largeicon")] [s []]
    in HH.p [HP.class_ $ HH.ClassName "icons"] $
        (mkSmallIcon <<< iconForAnswered <$> g.answeredQuestions)
            <> [mkLargeIcon <<< iconForCurrentView $ g.currentView]
            <> (mkSmallIcon <<< iconForQuestion <$> g.upcomingQuestions)

title = HH.p_
    [ HH.h1_ [HH.text "Extension or Imitation"]
    ]

extensionName name = 
    HH.p_ [ HH.span
        [HP.class_ $ HH.ClassName "extensionName"] 
        [ HH.text name ]
    ]

socialLink icon url = HH.a
        [ HP.href url
        , HP.target "_blank"
        , HP.class_ (HH.ClassName "socialLink")
        ]
        [ icon []
        ]

pageUrl = "https://doscienceto.it/extension-or-imitation"

sharingLink :: forall cs m . String -> String -> String -> Array AnsweredQuestion -> HH.ComponentHTML Action cs m
sharingLink linkText erata url s = 
    let 
      text = "I scored " <> resultsText s <> " on \"Extension Or Imitation\"\n" <> pageUrl <> "\nTry it out?\n" 
        <> erata <> "\n"
        <> "#Haskell #HaskellLanguageExtensionOrImitation"
      plainUrl = URL.unsafeFromAbsolute url
      -- toot.kytta.dev doesn't support + in URL parameters
      expandify = String.replaceAll (String.Pattern "+") (String.Replacement "%20")
      params = expandify <<< URLParams.toString <<<
          URLParams.append "text" text $
          URLParams.fromString ""
      sharingUrl = URL.toString $ URL.setSearch params plainUrl
    in HH.p_ [HH.a [HP.href sharingUrl] [HH.text linkText]]


sharingLinkMastodon :: forall cs m . Array AnsweredQuestion -> HH.ComponentHTML Action cs m
sharingLinkMastodon = sharingLink "Toot on Mastodon?" "via @hungryjoe@functional.cafe" "https://toot.kytta.dev/" 

sharingLinkBsky :: forall cs m . Array AnsweredQuestion -> HH.ComponentHTML Action cs m
sharingLinkBsky = sharingLink "Post on BlueSky?" "via @doscienceto.it" "https://bsky.app/intent/compose" 

        
bottomLinks = HH.p_
    [ socialLink Svg.githubIcon "https://github.com/joe-warren/haskell-language-extension-or-imitation"
    , socialLink Svg.mastodonIcon "https://functional.cafe/@hungryjoe"
    , socialLink Svg.bskyIcon "https://bsky.app/profile/doscienceto.it"
    ]


renderCurrentGame :: forall cs m. CurrentGame -> H.ComponentHTML Action cs m
renderCurrentGame state =
  HH.div_
    [ title 
    , icons state
    , case state.currentView of 
        ToAnswer question ->
            HH.div_ 
                [ 
                  HH.p 
                    [HP.class_ $ HH.ClassName "questionInfo"]
                    [ extensionName question.extension.name ]
                , HH.p [HP.class_ (HH.ClassName "buttons")]
                    [ HH.button
                        [ HE.onClick \_ -> GiveAnswer Real ]
                        [ HH.text "Extension" ]
                    , HH.button
                        [ HE.onClick \_ -> GiveAnswer Fake ]
                        [ HH.text "Imitation" ]
                    ]
                ]
        Answered answeredQuestion ->
            HH.div_ 
                [ HH.p 
                    [HP.class_ $ HH.ClassName "questionInfo"]
                    [ extensionName answeredQuestion.question.extension.name
                    , HH.p_ [ HH.text answeredQuestion.message ]
                    , HH.p_ [ HH.fromPlainHTML answeredQuestion.question.extension.description ]
                    ]
                , HH.p [HP.class_ $ HH.ClassName "buttons"]
                    [ HH.p_ 
                        [ HH.button 
                            ([ HP.disabled true
                             ] <> case answeredQuestion.question.correctAnswer of 
                                    Real -> [ HP.class_ $ HH.ClassName "correct" ]
                                    Fake -> case answeredQuestion.givenAnswer of   
                                        Fake -> []
                                        Real -> [ HP.class_ $ HH.ClassName "incorrect" ]
                            )
                            [ HH.text "Extension" ]
                        , HH.button 
                            ([ HP.disabled true 
                             ] <> case answeredQuestion.question.correctAnswer of 
                                    Fake -> [ HP.class_ $ HH.ClassName "correct" ]
                                    Real -> case answeredQuestion.givenAnswer of   
                                        Real -> []
                                        Fake -> [ HP.class_ $ HH.ClassName "incorrect" ]
                            )
                            [ HH.text "Imitation" ]
                    ]
                    , HH.button
                        [ HE.onClick \_ -> NextQuestion ]
                        [ HH.text (if Array.null state.upcomingQuestions then "Finish" else "Next") ]
                    ]
            ]
        {-- uncomment this to debug the extension appearance
        , HH.text $ "" <> show (Array.length realExtensions) <> " real, " <> show (Array.length fakeExtensions) <> " fake"
        , HH.fromPlainHTML <<< HH.span_ $ (\s -> HH.div_ [extensionName s.name, HH.p_ [s.description]]) <$> (realExtensions <> fakeExtensions)
        --}
    ]

render :: forall cs m. State -> H.ComponentHTML Action cs m
render s = HH.div_
    [ case s of 
        Results arr -> renderResults arr
        Playing st -> renderCurrentGame st
    , bottomLinks
    ]

nextQuestion :: State -> State
nextQuestion (Results r) = (Results r)
nextQuestion (Playing s) = 
    case s.currentView of 
        Answered answered ->
            case Array.uncons s.upcomingQuestions of
                Nothing -> Results (Array.snoc s.answeredQuestions answered)
                Just { head: x, tail: xs} -> Playing
                    { answeredQuestions: Array.snoc s.answeredQuestions answered
                    , upcomingQuestions: xs
                    , currentView: ToAnswer x
                    }
        _ -> Playing s


answer :: Answer -> State -> Effect State
answer _ (Results r) = pure (Results r)
answer ans (Playing s) =
    case s.currentView of 
        ToAnswer q -> do
            msg <- answerMessage ans q.correctAnswer
            pure ( Playing ( s{
                    currentView = Answered { givenAnswer: ans, message: msg, question: q }
                }))
        _ -> pure (Playing s)

-- given then expected
answerMessage :: Answer -> Answer -> Effect String
answerMessage Real Real = pickOr "" ["Well Done", "Well Spotted", "Nicely Done", "Correct", "Absolutely"]
answerMessage Fake Fake = pickOr "" ["Spot On", "No Fooling You", "It's Absolutely Fake", "It's Not Real"]
answerMessage Real Fake = pickOr "" ["Wrong", "Gotcha", "It's Fake", "Sorry"]
answerMessage Fake Real = pickOr "" ["It's Real", "Would You Believe it's Real", "It's a Real Extension"]
 
handleAction :: forall cs o m. MonadEffect m => Action -> H.HalogenM State Action cs o m Unit
handleAction = case _ of
    NewGame -> do 
        st <- liftEffect initializeGameState
        H.put st
    NextQuestion -> H.modify_ nextQuestion
    GiveAnswer ans -> do 
        s <- H.get 
        H.put =<< liftEffect (answer ans s)
  
  

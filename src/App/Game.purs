module App.Game
  ( Action(..)
  , Answer(..)
  , AnsweredQuestion
  , CurrentGame
  , CurrentView(..)
  , Question
  , State(..)
  , badQuestion
  , goodQuestion
  , handleAction
  , mkComponent
  , render
  , renderCurrentGame
  )
  where

import Prelude
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import App.Extensions
import Data.Array as Array
import Effect (Effect)
import Effect.Shuffle (shuffle)
import Data.Array.Extra.Unsafe (unsafeHead)
import Data.Maybe (Maybe (Just, Nothing))


data Answer = LanguageExtension | Imitation

type Question = 
    { correctAnswer :: Answer
    , extension :: Extension
    }

goodQuestion :: Extension -> Question
goodQuestion e = {correctAnswer: LanguageExtension, extension: e}

badQuestion :: Extension -> Question
badQuestion e = {correctAnswer: Imitation, extension: e}

type AnsweredQuestion = 
    { givenAnswer :: Answer
    , question :: Question
    }


data Action
  = NextQuestion
  | GiveAnswer Answer 

data CurrentView = ToAnswer Question | Answered AnsweredQuestion

type CurrentGame = 
    { answeredQuestions :: Array AnsweredQuestion
    , currentView :: CurrentView
    , upcomingQuestions :: Array Question
    }

data State
  = Playing CurrentGame | Results (Array AnsweredQuestion)

mkComponent :: forall q i o m. Effect (H.Component q i o m)
mkComponent = do
    good <- map goodQuestion <<< Array.take 6 <$> shuffle realExtensions
    bad <- map badQuestion <<< Array.take 6 <$> shuffle fakeExtensions
    questions <- shuffle (Array.concat [good, bad])
    
    pure $ H.mkComponent
        { initialState: \_ -> Playing 
            { answeredQuestions: []
            , currentView: ToAnswer (unsafeHead questions)
            , upcomingQuestions: Array.drop 1 questions
            }
        , render
        , eval: H.mkEval H.defaultEval { handleAction = handleAction }
        }

renderResults :: forall cs m. Array AnsweredQuestion -> H.ComponentHTML Action cs m
renderResults res = HH.div_ [HH.text "Game Over"]

renderCurrentGame :: forall cs m. CurrentGame -> H.ComponentHTML Action cs m
renderCurrentGame state =
  HH.div_
    [ HH.p_
        [ HH.text $ "Language Extension Quiz " <> show (Array.length realExtensions) <> " real, " <> show (Array.length fakeExtensions) <> " fake"]
    , case state.currentView of 
        ToAnswer question ->
            HH.div_ 
                [ HH.p_ [ HH.text question.extension.name ]
                , HH.button
                    [ HE.onClick \_ -> GiveAnswer LanguageExtension ]
                    [ HH.text "Extension" ]
                , HH.button
                    [ HE.onClick \_ -> GiveAnswer Imitation ]
                    [ HH.text "Imitation" ]
                ]
        Answered answeredQuestion ->
            HH.div_ 
                [ HH.p_ [ HH.text answeredQuestion.question.extension.name ]
                , HH.p_ [ HH.fromPlainHTML answeredQuestion.question.extension.description ]
                , HH.button
                    [ HE.onClick \_ -> NextQuestion ]
                    [ HH.text "Next" ]
            ]
    ]

render :: forall cs m. State -> H.ComponentHTML Action cs m
render = case _ of 
    Results arr -> renderResults arr
    Playing st -> renderCurrentGame st

nextQuestion :: State -> State
nextQuestion (Results r) = (Results r)
nextQuestion (Playing s) = 
    case s.currentView of 
        Answered answered ->
            case Array.uncons s.upcomingQuestions of
                Nothing -> Results s.answeredQuestions
                Just { head: x, tail: xs} -> Playing
                    { answeredQuestions: Array.snoc s.answeredQuestions answered
                    , upcomingQuestions: xs
                    , currentView: ToAnswer x
                    }
        _ -> Playing s

answer :: Answer -> State -> State
answer _ (Results r) = (Results r)
answer ans (Playing s) =
    case s.currentView of 
        ToAnswer q -> Playing ( s{
            currentView = Answered { givenAnswer: ans, question: q}

        })
        _ -> (Playing s)



handleAction :: forall cs o m. Action → H.HalogenM State Action cs o m Unit
handleAction = case _ of
  NextQuestion -> H.modify_ nextQuestion
  GiveAnswer ans -> H.modify_ (answer ans) 
  
  

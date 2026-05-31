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
import App.Svg as Svg
import Data.Array as Array
import Effect (Effect)
import Effect.Shuffle (shuffle, pickOr)
import Data.Array.Extra.Unsafe (unsafeHead)
import Data.Maybe (Maybe (Just, Nothing))
import Effect.Class (class MonadEffect, liftEffect)

data Answer = Real | Fake 

derive instance Eq Answer

type Question = 
    { correctAnswer :: Answer
    , extension :: Extension
    }

goodQuestion :: Extension -> Question
goodQuestion e = {correctAnswer: Real, extension: e}

badQuestion :: Extension -> Question
badQuestion e = {correctAnswer: Fake, extension: e}

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

data CurrentView = ToAnswer Question | Answered AnsweredQuestion

type CurrentGame = 
    { answeredQuestions :: Array AnsweredQuestion
    , currentView :: CurrentView
    , upcomingQuestions :: Array Question
    }

data State
  = Playing CurrentGame | Results (Array AnsweredQuestion)

mkComponent :: forall q i o m. MonadEffect m => Effect (H.Component q i o m)
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
renderResults res = 
    let nRounds = Array.length res
        score = Array.length <<< Array.filter isCorrect $ res
    in HH.div_ 
        [ HH.h2_ [ HH.text "Game Over" ]
        , HH.p_ 
            [ HH.text $ "You Scored " <> show score <> " / " <> show nRounds
            ]
        ]

renderCurrentGame :: forall cs m. CurrentGame -> H.ComponentHTML Action cs m
renderCurrentGame state =
  HH.div_
    [ HH.p_
        [ HH.h1_ [HH.text "Extension or Imitation"]
        , Svg.amongusDefaultIcon []
        ]
    , case state.currentView of 
        ToAnswer question ->
            HH.div_ 
                [ HH.p_ [ HH.text question.extension.name ]
                , HH.button
                    [ HE.onClick \_ -> GiveAnswer Real ]
                    [ HH.text "Extension" ]
                , HH.button
                    [ HE.onClick \_ -> GiveAnswer Fake ]
                    [ HH.text "Imitation" ]
                ]
        Answered answeredQuestion ->
            HH.div_ 
                [ HH.p_ [ HH.text answeredQuestion.question.extension.name ]
                , HH.p_ [ HH.text answeredQuestion.message ]
                , HH.p_ [ HH.fromPlainHTML answeredQuestion.question.extension.description ]
                , HH.button
                    [ HE.onClick \_ -> NextQuestion ]
                    [ HH.text "Next" ]
            ]
        , HH.text $ "" <> show (Array.length realExtensions) <> " real, " <> show (Array.length fakeExtensions) <> " fake"
        , HH.fromPlainHTML <<< HH.span_ $ (\s -> HH.div_ [HH.p_ [HH.text s.name], HH.p_ [s.description]]) <$> (realExtensions <> fakeExtensions)
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
  NextQuestion -> H.modify_ nextQuestion
  GiveAnswer ans -> do 
    s <- H.get 
    H.put =<< liftEffect (answer ans s)
  
  

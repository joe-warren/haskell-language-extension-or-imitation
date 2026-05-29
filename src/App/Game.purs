module App.Game where

import Prelude
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import App.Extensions

data Answer = LanguageExtension | Imitation

type Question = 
    { correctAnswer :: Answer
    , extension :: Extension
    }

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

component :: forall q i o m. H.Component q i o m
component =
  H.mkComponent
    { initialState: \_ -> Results []
    , render
    , eval: H.mkEval H.defaultEval { handleAction = handleAction }
    }

render :: forall cs m. State -> H.ComponentHTML Action cs m
render _state =
  HH.div_
    [ HH.p_
        [ HH.text $ "Language Extension Quiz" ]
    , HH.button
        [ HE.onClick \_ -> NextQuestion ]
        [ HH.text "Click me" ]
    ]

handleAction :: forall cs o m. Action → H.HalogenM State Action cs o m Unit
handleAction = case _ of
  NextQuestion -> H.modify_ \st -> st 
  GiveAnswer _ -> H.modify_ \st -> st 
  
  

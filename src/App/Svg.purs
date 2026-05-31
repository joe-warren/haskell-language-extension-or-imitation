module App.Svg where

import Prelude

import Halogen.HTML (HTML, IProp)
import Svg.Renderer.Halogen (icon)

foreign import amongusDefault :: String
foreign import amongusDead :: String
foreign import amongusImpostor :: String
foreign import amongusThumbsup :: String

amongusDefaultIcon :: forall p r i. Array (IProp r i) -> HTML p i
amongusDefaultIcon = icon amongusDefault

amongusDeadIcon :: forall p r i. Array (IProp r i) -> HTML p i
amongusDeadIcon = icon amongusDead

amongusImpostorIcon :: forall p r i. Array (IProp r i) -> HTML p i
amongusImpostorIcon = icon amongusImpostor

amongusThumbsupIcon :: forall p r i. Array (IProp r i) -> HTML p i
amongusThumbsupIcon = icon amongusThumbsup





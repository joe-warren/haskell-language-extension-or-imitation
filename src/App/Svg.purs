module App.Svg where

import Prelude

import Halogen.HTML (HTML, IProp)
import Svg.Renderer.Halogen (icon)

foreign import amongusDefault :: String

amongusDefaultIcon :: forall p r i. Array (IProp r i) -> HTML p i
amongusDefaultIcon = icon amongusDefault


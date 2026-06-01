module App.Svg where

import Prelude

import Halogen.HTML (HTML, IProp)
import Svg.Renderer.Halogen (icon)

foreign import amongusDefault :: String
foreign import amongusDead :: String
foreign import amongusImpostor :: String
foreign import amongusThumbsup :: String

foreign import github :: String
foreign import mastodon :: String
foreign import bsky :: String

foreign import intro :: String

amongusDefaultIcon :: forall p r i. Array (IProp r i) -> HTML p i
amongusDefaultIcon = icon amongusDefault

amongusDeadIcon :: forall p r i. Array (IProp r i) -> HTML p i
amongusDeadIcon = icon amongusDead

amongusImpostorIcon :: forall p r i. Array (IProp r i) -> HTML p i
amongusImpostorIcon = icon amongusImpostor

amongusThumbsupIcon :: forall p r i. Array (IProp r i) -> HTML p i
amongusThumbsupIcon = icon amongusThumbsup

githubIcon :: forall p r i. Array (IProp r i) -> HTML p i
githubIcon = icon github

mastodonIcon :: forall p r i. Array (IProp r i) -> HTML p i
mastodonIcon = icon mastodon

bskyIcon :: forall p r i. Array (IProp r i) -> HTML p i
bskyIcon = icon bsky

introIcon :: forall p r i. Array (IProp r i) -> HTML p i
introIcon = icon intro

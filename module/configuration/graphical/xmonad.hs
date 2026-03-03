import XMonad
import XMonad.Util.EZConfig (additionalKeysP)

import XMonad.Layout.Monitor
  ( Monitor(..)
  , monitor
  , manageMonitor
  , MonitorMessage(ToggleMonitor)
  , Property(ClassName)
  )

import XMonad.Layout.LayoutModifier (ModifiedLayout(..))
import Graphics.X11 (Rectangle(..))
import XMonad.Hooks.ManageDocks (docks)
import qualified XMonad.StackSet as W
import Data.Maybe (listToMaybe)

myToggleXmobar :: String
myToggleXmobar = "pgrep -x xmobar >/dev/null && pkill -x xmobar || /run/current-system/sw/bin/xmobar &"

xmobarMonitor :: Monitor Window
xmobarMonitor = monitor
  {
    prop       = ClassName "xmobar"
  , rect       = Rectangle 0 0 1920 24
  , visible    = False
  , persistent = True
  , name       = "xmobar"
  , opacity    = 1
  }

myManageHook :: ManageHook
myManageHook = manageMonitor xmobarMonitor

myLayout = ModifiedLayout xmobarMonitor (Tall 1 (3/100) (1/2) ||| Full)

toggleScreen :: X ()
toggleScreen = do
  ws <- gets windowset
  let cur = W.current ws
      visibles = W.visible ws
      otherScreen = listToMaybe $ filter (\s -> W.screen s /= W.screen cur) visibles
  case otherScreen of
    Just s -> case W.tag (W.workspace s) of
                w -> windows (W.view w)
    Nothing -> return ()

myTerminal :: String
myTerminal = "alacritty"

main :: IO ()
main = xmonad $ docks def
  { modMask     = mod4Mask
  , terminal    = myTerminal
  , borderWidth = 0
  , layoutHook  = myLayout
  , manageHook  = myManageHook <+> manageHook def
  }
  `additionalKeysP`
  [ ("M-q", spawn "xmonad --restart")
  , ("M-e", spawn "emacs")
  , ("M-b", spawn myToggleXmobar >> broadcastMessage ToggleMonitor >> refresh)
  , ("M-w", toggleScreen)
  , ("M-s m m", spawn "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") 
  , ("M-s m t", spawn "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") 
  , ("M-s m s", spawn "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
  , ("M-x", spawn "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
  , ("M-s m e", spawn "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0")
  , ("M-s m d", spawn "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1")
  , ("M-s b e", spawn "bluetoothctl power on")
  , ("M-s b d", spawn "bluetoothctl power off")
  , ("M-`", spawn myTerminal)
  , ("M-s p p", spawn "playerctl play-pause")
  , ("M-s p e", spawn "playerctl play")
  , ("M-s p d", spawn "playerctl pause")
  , ("M-s p k", spawn "playerctl stop")
  , ("M-s p f", spawn "playerctl position +30")
  , ("M-s p b", spawn "playerctl position -30")
  , ("M-s p v `", spawn "playerctl volume 0")
  , ("M-s p v 1", spawn "playerctl volume 0.1")
  , ("M-s p v 2", spawn "playerctl volume 0.2")
  , ("M-s p v 3", spawn "playerctl volume 0.3")
  , ("M-s p v 4", spawn "playerctl volume 0.4")
  , ("M-s p v 5", spawn "playerctl volume 0.5")
  , ("M-s p v 6", spawn "playerctl volume 0.6")
  , ("M-s p v 7", spawn "playerctl volume 0.7")
  , ("M-s p v 8", spawn "playerctl volume 0.8")
  , ("M-s p v 9", spawn "playerctl volume 0.9")
  , ("M-s p v 0", spawn "playerctl volume 1")
  , ("M-s p l d", spawn "playerctl loop None")
  , ("M-s p l e", spawn "playerctl loop Track")
  , ("M-s p s s", spawn "playerctl shuffle Toggle")
  , ("M-s p s t", spawn "playerctl shuffle Toggle")
  , ("M-s p s e", spawn "playerctl shuffle On")
  , ("M-s p s d", spawn "playerctl shuffle Off")
  , ("<XF86AudioPlay>", spawn "playerctl play-pause")
  , ("M-z", spawn "xdotool keyup Super_L+z && xset dpms force off")
  , ("M-v", spawn "copyq menu")
  , ("<Print>", spawn "maim -s | xclip -selection clipboard -t image/png")
  , ("M-<Print>", spawn "maim | xclip -selection clipboard -t image/png")
  , ("M-<Alt_L> <Print>", spawn "maim ~/Pictures/Screenshots/$(date +\"%4Y.%m.%d_%T.%N\").png")
  , ("M-n a", spawn "dunstctl action")
  , ("M-n c", spawn "dunstctl close")
  , ("M-s v `", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0")
  , ("M-s v 1", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1")
  , ("M-s v 2", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.2")
  , ("M-s v 3", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.3")
  , ("M-s v 4", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.4")
  , ("M-s v 5", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.5")
  , ("M-s v 6", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.6")
  , ("M-s v 7", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.7")
  , ("M-s v 8", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.8")
  , ("M-s v 9", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.9")
  , ("M-s v 0", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1")
  , ("M-s w e", spawn "nmcli radio wifi on")
  , ("M-s w d", spawn "nmcli radio wifi off")
  ]

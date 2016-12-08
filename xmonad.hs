import XMonad
import XMonad.Layout.NoBorders
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers

import XMonad.Util.Dmenu
import XMonad.Util.Run(spawnPipe)

import System.Exit
import System.IO

import Control.Monad

import qualified Data.Map as M

import Data.Time.LocalTime (getZonedTime)
import System.Locale (defaultTimeLocale)
import Data.Time.Format (formatTime)

takeScreenshot :: X ()
takeScreenshot = do
  t <- liftIO getZonedTime
  let iso = formatTime defaultTimeLocale "%FT%T" t
  spawn $ "import 'screenshot_" ++ iso ++ ".png'"

quitWithWarning :: X()
quitWithWarning = do
  let m = "confirm quit"
  a <- dmenu [m, "y", "n"]
  when (a == "y") (io exitSuccess)

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myManageHook = composeOne
    [
      className =? "Emacs"               -?> doShift "1:dev"
    , className =? "Google-chrome"       -?> doShift "2:web"
    , className =? "Icedove"             -?> doShift "5:mail"
    , title     =? "FQTerm Image Viewer" -?> doFloat
    --, title     =? "fqterm.bin"          -?> doIgnore
    , isDialog                           -?> doFloat
    ]

main = xmonad $ ewmh defaultConfig
    { terminal    = "urxvt"
    , modMask     = mod4Mask
    , keys        = myKeys
    , workspaces  = ["1:dev","2:web","3","4","5:mail","6","7","8","9","0","-","="]
    , manageHook  = myManageHook <+> insertPosition End Newer
    , handleEventHook = handleEventHook
                       defaultConfig <+> fullscreenEventHook
    , focusFollowsMouse  = myFocusFollowsMouse
    }

myKeys x = M.union (M.fromList (newKeys x)) (keys defaultConfig x)

newKeys conf@(XConfig {XMonad.modMask = modm}) = [
  -- ((modm, xK_l), spawn "xscreensaver-command -lock")
  -- ((modm .|. shiftMask, xK_l), spawn "xtrlock")
  ((modm .|. shiftMask, xK_l), spawn "slock")
  ,((modm , xK_Print), takeScreenshot)
  ,((modm .|. shiftMask, xK_q), quitWithWarning)
  -- other keybindings here
  ]

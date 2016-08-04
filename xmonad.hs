import XMonad
import XMonad.Layout.NoBorders
import XMonad.Hooks.InsertPosition

import XMonad.Util.Run(spawnPipe)
import System.IO
import qualified Data.Map as M

import Data.Time.LocalTime (getZonedTime)
import System.Locale (defaultTimeLocale)
import Data.Time.Format (formatTime)

takeScreenshot :: X ()
takeScreenshot = do
  t <- liftIO getZonedTime
  let iso = formatTime defaultTimeLocale "%FT%T" t
  spawn $ "import 'screenshot_" ++ iso ++ ".png'"

main = xmonad defaultConfig
    { terminal    = "urxvt"
    , modMask     = mod4Mask
    ,keys         = myKeys
    ,manageHook   = insertPosition End Newer
    }
    
myKeys x = M.union (M.fromList (newKeys x)) (keys defaultConfig x)    

newKeys conf@(XConfig {XMonad.modMask = modm}) = [
  -- ((modm, xK_l), spawn "xscreensaver-command -lock")
  -- ((modm .|. shiftMask, xK_l), spawn "xtrlock")
  ((modm .|. shiftMask, xK_l), spawn "slock")
  ,((modm , xK_Print), takeScreenshot)
  -- other keybindings here
  ]

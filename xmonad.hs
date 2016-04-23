import XMonad
import XMonad.Layout.NoBorders

import XMonad.Util.Run(spawnPipe)
import System.IO
import qualified Data.Map as M


main = xmonad defaultConfig
    { terminal    = "urxvt"
    , modMask     = mod4Mask
    ,keys         = myKeys                    
    }
    
myKeys x = M.union (M.fromList (newKeys x)) (keys defaultConfig x)    

newKeys conf@(XConfig {XMonad.modMask = modm}) = [
  -- ((modm, xK_l), spawn "xscreensaver-command -lock")
  -- ((modm .|. shiftMask, xK_l), spawn "xtrlock")
  ((modm .|. shiftMask, xK_l), spawn "slock")
  -- other keybindings here
  ]

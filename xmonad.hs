import XMonad
import XMonad.Layout.NoBorders

--import XMonad.Util.Run(spawnPipe)
--import System.IO

--import qualified Data.Map as M


--myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
--  [ ((modMask, xK_l), spawn "xscreensaver-command -lock; xset dpms force off")
--        -- other keybindings here
--      ]

main = xmonad defaultConfig
    { terminal    = "urxvt"
    , modMask     = mod4Mask
    }

-- George 'papanikge' Papanikolaou xmonad config file
-- 24/10/13 Switching to XMonad

import XMonad
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat, isDialog)
import XMonad.Layout.NoBorders
import XMonad.Actions.CycleWS
import System.IO
import qualified XMonad.StackSet as W

myTerminal   = "urxvt"
myWorkspaces = ["1:main","2:web","3:vim","4:skype","5:irc","6:torrent","7","8","9:spotify"]

-- to manage windows
myManageHook = composeAll
    [ className =? "MPlayer"             --> doCenterFloat
    , className =? "mpv"                 --> doCenterFloat
    , className =? "Keepassx"            --> doCenterFloat
    , className =? "feh"                 --> doCenterFloat
    , className =? "Dialogue"            --> doCenterFloat
    , className =? "Xmessage"            --> doCenterFloat
    , className =? "Octave"              --> doCenterFloat
    , className =? "qemu-system-x86_64"  --> doFloat
    , resource  =? "anamnesis"           --> doCenterFloat
    , resource  =? "skype"               --> doShift "4:skype"
    , resource  =? "transmission-qt"     --> doShift "6:torrent"
    , resource  =? "spotify"             --> doShift "9:spotify"
    , resource  =? "desktop_window"      --> doIgnore
    , title     =? "Save a Bookmark"     --> doCenterFloat
    , title     =? "Dropbox Preferences" --> doCenterFloat
    , title     =? "Firefox Preferences" --> doCenterFloat
    , isFullscreen                       --> doFullFloat
    , isDialog                           --> doCenterFloat
    ]

-- to be runned at X11 startup
myStartupHook :: X ()
myStartupHook = do
    -- these may need to go ...
    spawn "synclient TapButton1=0"
    spawn "synclient TapButton2=0"
    spawn "synclient TapButton3=0"
    spawn "synclient PalmDetect=1"
    spawn "xmodmap ~/.Xmodmap >/dev/null"
    -- daemons
    spawn "dropboxd"
    spawn "mpd"
    spawn "unclutter"
    spawn "anamnesis --start"
    spawn "dunst -config /home/g3orge/.dunstrc"

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/g3orge/.xmonad/xmobar.hs"
    xmonad $ defaultConfig {
      terminal           = myTerminal
    , modMask            = mod4Mask
    , borderWidth        = 1
    , normalBorderColor  = "#000000"  -- black
    , focusedBorderColor = "#456def"  -- blue
    , workspaces         = myWorkspaces
    , focusFollowsMouse  = False
    , clickJustFocuses   = False
    , manageHook    = manageDocks <+> myManageHook <+> manageHook defaultConfig
    , layoutHook    = smartBorders $ avoidStruts $ layoutHook defaultConfig
    , startupHook   = myStartupHook
    , logHook = dynamicLogWithPP xmobarPP {
            ppOutput = hPutStrLn xmproc -- for the status bar
          , ppTitle  = xmobarColor "blue" "" . shorten 30
          , ppLayout = const ""
          }
    } `additionalKeys`
      [ -- XF86LaunchA
      ((0, 0x1008FF4A), spawn "chromium")
      -- XF86LaunchB
      , ((0, 0x1008FF4B), spawn "gvim")
      -------- Keyboard --------
      -- XF86KbdBrightnessDown
      , ((0, 0x1008FF06), spawn "~/.dotfiles/bin/spotify-control.sh play")
      -- XF86KbdBrightnessUp
      , ((0, 0x1008FF05), spawn "~/.dotfiles/bin/change_lang.sh")
      -------- Monitor ---------
      -- XF86MonBrightnessDown
      , ((0, 0x1008FF03), spawn "~/.dotfiles/bin/brightness-down.sh")
      -- XF86MonBrightnessUp
      , ((0, 0x1008FF02), spawn "~/.dotfiles/bin/brightness-up.sh")
      --------- Audio ----------
      -- XF86AudioPrev
      , ((0, 0x1008FF16), spawn "ncmpcpp prev")
      -- XF86AudioPlay
      , ((0, 0x1008FF14), spawn "ncmpcpp toggle")
      -- XF86AudioNext
      , ((0, 0x1008FF17), spawn "ncmpcpp next")
      -- XF86AudioMute
      , ((0, 0x1008FF12), spawn "amixer set Master toggle")
      -- XF86AudioLowerVolume
      , ((0, 0x1008FF11), spawn "amixer set Master 5%- unmute")
      -- XF86AudioRaiseVolume
      , ((0, 0x1008FF13), spawn "amixer set Master 5%+ unmute")
      -- XF86Eject
      , ((0, 0x1008FF2C), spawn "~/.dotfiles/bin/blur-lockscreen.sh")

      -- mod + return --> terminal
      , ((mod4Mask, xK_Return), spawn myTerminal)
      -- and mod + shift + return to swap master panel
      , ((mod4Mask .|. shiftMask, xK_Return), windows W.swapMaster)
      -- dmenu
      , ((mod4Mask, xK_d), spawn "dmenu_run -nb black -nf white -l 4")
      -- mod + q --> kill focused window
      , ((mod4Mask, xK_q), kill)
      -- mod + shift + r --> reload
      , ((mod4Mask .|. shiftMask, xK_r), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")
      -- alt(mod1Mask)+TAB -- cycle through recent workspaces
      , ((mod1Mask, xK_Tab), toggleWS)
      ]

      `removeKeys` -- un-register bindings here...
      [
        (mod4Mask .|. shiftMask, xK_c)
      ]

      `additionalKeysP` -- emacs style shortcuts (for ctrl capturing)
      [
        ("C-<Space>", spawn "anamnesis --browse")
      ]

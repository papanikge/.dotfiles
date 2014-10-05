-- papanikge's xmobar config file
-- check the .xmonad/xmonad.hs file for more

Config { font = "xft:Sans-8:bold"
       , bgColor = "black"
       , fgColor = "grey"
       , position = Static { xpos = 0 , ypos = 0, width = 1245, height = 16 }
       , commands = [ Run Memory ["-t","<fc=lightgreen><icon=/home/g3orge/.xmonad/mem.xbm/> <usedratio>%</fc>"] 10
                    , Run Battery ["-t", "<fc=#47666a><icon=/home/g3orge/.xmonad/bat.xbm/></fc> <left>% ~ <timeleft>",
                                   "-p", "3",
                                   "--", "-O", "<fc=green>/</fc>", "-o", "<fc=red>/</fc>",
                                   "-l", "red", "-m", "blue", "-h", "green"]
                                   100
                    , Run Date "%a, %b %_d %Y %H:%M " "date" 10
                    , Run Com "~/.dotfiles/bin/getvolume.sh" [] "volume" 20
                    , Run Com "/bin/bash" ["-c", "find /home/g3orge/Mail/CEID/CEIDPublicMail.students-all.STUDENTS2010/new /home/g3orge/Mail/CEID/CEIDPublicMail.students-all/new /home/g3orge/Mail/CEID/INBOX/new -type f | wc -l"] "mail" 100
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{ [ <fc=#c0362c><icon=/home/g3orge/.xmonad/mail.xbm/> %mail%</fc> ][ %memory% ][ <icon=/home/g3orge/.xmonad/vol.xbm/> <fc=#6699cc>%volume%</fc> ][ %battery% ][ <fc=#ee9a00>%date%</fc>"
       }

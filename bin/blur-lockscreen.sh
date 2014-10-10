#!/bin/bash
# from: http://plankenau.com/blog/post-10/gaussianlock
#
# schedule this with something like:
# xautolock -time 10 -locker lock

scrot /tmp/screenshot.png
convert /tmp/screenshot.png -blur 0x5 /tmp/screenshotblur.png
i3lock -i /tmp/screenshotblur.png
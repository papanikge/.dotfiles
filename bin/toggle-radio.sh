#!/bin/bash

if [ -z "$(pgrep mplayer)" ]; then
  mplayer http://ice6.somafm.com/missioncontrol-128-aac
else
  pgrep mplayer | xargs kill
fi

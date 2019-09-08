#!/bin/bash

if [ -z "$(setxkbmap -query | grep ' el')" ]; then
  setxkbmap el
else
  setxkbmap us
fi

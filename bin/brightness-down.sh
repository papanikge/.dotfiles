#!/bin/bash

l=$(xbacklight -get | cut -d. -f1)

[[ $l -lt 7   ]] && exit
[[ $l -lt 50  ]] && xbacklight -set 7 && exit
[[ $l -lt 101 ]] && xbacklight -set 50 && exit

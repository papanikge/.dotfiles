#!/bin/bash

l=$(xbacklight -get | cut -d. -f1)

[[ $l -ge 101 ]] && exit
[[ $l -ge 40  ]] && xbacklight -set 100 && exit
[[ $l -ge 6   ]] && xbacklight -set 50 && exit

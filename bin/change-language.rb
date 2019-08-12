#!/usr/bin/ruby

if `setxkbmap -query | grep layout | awk '{print $2}'`.chomp == "us"
  `setxkbmap el`
else
  `setxkbmap us`
end

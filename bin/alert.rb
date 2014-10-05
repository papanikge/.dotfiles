#!/usr/bin/env ruby
require "daemons"

exit -1 unless ARGV.size == 1

Daemons.daemonize

given = ARGV[0]
if given =~ /^\d*s$/
    how_much = given.chop.to_i
elsif given =~ /^\d*m$/
    how_much = given.chop.to_i * 60
elsif given =~ /^\d*h$/
    how_much = given.chop.to_i * 3600
else
    puts "alert [s:seconds m:minutes h:hours]"
    exit -1
end

sleep how_much

# Notify:
`notify-send -u critical -t 3000 "Hey your #{given} are OVER"`
`ncmpcpp toggle`

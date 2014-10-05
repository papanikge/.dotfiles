#!/usr/bin/env ruby
# George 'papanikge' Papanikolaou 2013
# This is an ls++ wrapper, so it can display the actual sizes.
# Perhaps I should fork the repo and rewrite it in Perl (?)

# we get the arguments from ls++
out = `/bin/ls #{ARGV.join(' ')}`
# convert to array
con = out.split("\n")

# we don't want the size
size = con.shift

con.map! do |i|
  i.split(" ")
end

# replacing
con.each do |i|
  # The name (and the color) is the seventh element
  text = i[6].gsub(/\033\[[0-9;]*m/, '')
  # the size is fifth
  i[4] = `du -sh #{text} | cut -f1`.chomp
  # TODO: handle spaces
end

# finally reconstruct and print
con.map! do |i|
  i.join(" ")
end
# the output is not columnar but ls++ fixes it
puts con

# old regex
# text = i[6].gsub(/\e\[\d{0,2};?\d{0,2}m/, '')

#!/usr/bin/env ruby
#
# wr(1) --- watch and run (commands)
# papanikge 2014
#

require 'rb-inotify'

$FILE = ".wr_comm"

if ARGV.include?("--stop") || ARGV.include?("-s")
  `kill #{File.read(daemons.rb.pid)}`
else
  # init mode
  if !File.exists?($FILE) || File.zero?($FILE)
    warn "First add a command to run to a .wr_comm file"
    exit
  end

  # file is present so check for command TODO: safety?
  $COMM = File.read($FILE)
  notifier = INotify::Notifier.new

  # files for the command to be runned upon are the first arguments
  ARGV.each do |f|
    # different actions if pathnames are files or directories
    if File.file?(f)
      notifier.watch(f, :modify) { system($COMM) } # TODO: templates in file?
    elsif File.directory?(f)
      notifier.watch(f, :moved_to, :create) { system($COMM) }
    end
  end

  # it does not work for some reason with the Daemons gem
  Process.daemon(nochdir=true, noclose=true)
  # the following blocks so we need it last
  notifier.run
end

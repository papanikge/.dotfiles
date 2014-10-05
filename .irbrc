#
# ruby interactive mode configuration
#


# Autocomplete
require 'irb/completion'

# Prompt settings
ARGV.concat ["--readline", "--prompt-mode", "simple"]

# History
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

IRB.conf[:PROMPT_MODE] = :SIMPLE

class Object
  # Return only the methods not present on basic objects
  def interesting_methods
    (self.methods - Object.instance_methods).sort
  end
end

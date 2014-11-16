#!/usr/bin/env ruby
# Send batch mail without the recipients identify each other
# Arguments are the recipients
# papanikge 2013

require 'mail'

abort if ARGV.empty?

# Sensitive info. I'm too lazy to make these configurable instead of hard coded
OUR_EMAIL = ''
PASS      = ''

# What to send?
SUBJ = ''
BODY = %{}

# Initial settings. Maybe get them from arguments..
options = { :address              =>  "smtp.gmail.com",
            :port                 =>  587,
            :authentication       =>  'plain',
            :user_name            =>  OUR_EMAIL,
            :password             =>  PASS,
            :enable_starttls_auto =>  true
}
Mail.defaults { delivery_method :smtp, options }

# Sending
ARGV.each do |arg|
  Mail.deliver do
         to arg
       from OUR_EMAIL
    subject SUBJ
       body BODY
  end
  puts "Mail sent to #{arg}"
end

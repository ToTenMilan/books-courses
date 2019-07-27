require 'highline'

hl = HighLine.new
friends = hl.ask("Frineds?", lambda { |s| s.split(',') })
puts "your friends: #{friends.inspect}"
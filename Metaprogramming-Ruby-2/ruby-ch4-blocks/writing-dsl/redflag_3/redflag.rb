def event(description, &block) # '&' converts passed block to proc (do not execute now)
  @events << { :description => description, :condition => block} # store desc and proc (uncalled function) in @events hash
end

def setup(&block)
  @setups << block
end

def call_event(description)
  puts "ALERT: #{description}" if yield
end

def call_setup
  yield
end

@events = []
@setups = []
load 'events.rb'

@events.each do |e|
  @setups.each do |s|
    call_setup(&s)
  end
  call_event(e[:description], &e[:condition])
end

##### desired output:
# Setting up sky
# Setting up mountains
# ALERT: the sky is falling
# Setting up sky
# Setting up mountains
# ALERT: it's getting closer 
# Setting up sky
# Setting up mountains
#### Think of procs as unexecuted function in JS
#### There are two usages of ampersand in method arguments
#### '&' in last argument METHOD DEFINITION is changing block passed to it in method call, to such unexecuted function (proc)
#### '&' in last argument METHOD CALL is like calling this method with block (check line 28-30, 32-34) 

def event(description, &block) # '&' converts passed block to proc (do not execute now)
  @events << { :description => description, :condition => block} # store desc and proc (uncalled function) in @events hash
end

def setup(&block) # 'block' is converted to Proc to be able to pass around
  @setups << block # in JS its function without parentheses '()' [unexecuted function]
end

def call_event(description)
  puts "ALERT: #{description}" if yield
end

def call_setup
  yield # execute passed proc (function), like in JS '()'
end

@events = []
@setups = []
load 'events.rb'

# my solution
@events.each do |event_hash|
  @setups.each do |setup_proc|
    call_setup(&setup_proc) # call setup is only executing passed proc (function)
    # alternatively
    # call_setup { setup_proc.call } # in JS it would be setup_proc()
  end
  call_event(event_hash[:description], &event_hash[:condition])
  # alternatively
  # call_event(event_hash[:description]) { event_hash[:condition].call }
end

# book solution
# does not work in ruby 2.6.0p0 (2018-12-25 revision 66547) [x86_64-linux]
#
# @events.each do |e|
#   @setups.each do |s|
#     setup.call
#   end
#   puts ​"ALERT: ​#{event[:description]}​"​ ​if​ event[:condition].call
# end

##### desired output:
# Setting up sky
# Setting up mountains
# ALERT: the sky is falling
# Setting up sky
# Setting up mountains
# ALERT: it's getting closer 
# Setting up sky
# Setting up mountains
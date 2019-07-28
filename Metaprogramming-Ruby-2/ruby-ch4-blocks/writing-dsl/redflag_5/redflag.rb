lambda { # Shared scope
  # methods local only for this lambda (only for methods defined here)
  setups = []
  events = []

  Kernel.send :define_method, :setup do |&block|
    setups << block
  end

  Kernel.send :define_method, :event do |description, &block|
    events << { :description => description, :condition => block }
  end

  Kernel.send :define_method, :each_setup do |&block|
    setups.each do |setup|
      block.call setup
    end
  end

  Kernel.send :define_method, :each_event do |&block|
    events.each do |event|
      block.call event
    end
  end

  Kernel.send :define_method, :setup_call do |&block|
    block.call
  end

  Kernel.send :define_method, :event_call do |description, &block|
    puts "ALERT: #{description}" if block.call
  end
}.call # defining above methods in main scope (the same methods as in redflag_3)

load 'events.rb'

each_event do |event|
  env = Object.new # execute events in "Clean Room" to make them as independent as possible
  each_setup do |setup|
    # setup.call
    # setup_call(&setup)
    env.instance_eval &setup # evaluale in context of an Object instance
  end
  # puts "ALERT: ​#{event[:description]}​"​ ​if​ event[:condition].call
  event_call(event[:description], &event[:condition])
end
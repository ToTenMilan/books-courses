lambda {
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
}.call

load 'events.rb'

each_event do |event|
  each_setup do |setup|
    # setup.call
    setup_call(&setup)
  end
  # puts "ALERT: ​#{event[:description]}​"​ ​if​ event[:condition].call
  event_call(event[:description], &event[:condition])
end
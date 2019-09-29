 
threads = []
10.times do |i|
  t = Thread.new { while true do; end}
  threads << t
end
threads[0].join()

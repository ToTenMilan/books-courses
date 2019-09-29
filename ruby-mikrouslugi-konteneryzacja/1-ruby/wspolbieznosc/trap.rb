puts "initializing worker processes..."
pids = 5.times.map do |i| # return 5 process ids to pids
  fork do
    trap("TERM") do
      puts "Worker#{i}: kill signal received...shutting down"
      exit
    end # trap
    loop do
      puts "Worker#{i}: `crunches numbers`"
      sleep rand(1..3)
    end # loop
  end # fork
end # 5.times.map

sleep 5
puts "killing worker processes..."
pids.each { |pid| Process.kill(:TERM, pid) }
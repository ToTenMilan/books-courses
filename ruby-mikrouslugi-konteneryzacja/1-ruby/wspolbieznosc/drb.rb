require 'drb'

NUM_WORKERS = 4

class Worker
  def calculate
    time_to_work = rand(1..7)
    sleep time_to_work
    return time_to_work
  end # calculate
  def stop
    DRb.stop_service
  end # stop
end # Worker

# Uruchomienie usługi
NUM_WORKERS.times do |i|
  DRb.start_service("druby://:700#{i}", Worker.new)
  puts "Worker running at #{DRb.uri}"
end # NUM_WORKERS.times

# Workers
workers = NUM_WORKERS.times.map { |i| 
  DRbObject.new nil, "druby://:700#{i}" 
}

# Wątki
thread_pool = []
NUM_WORKERS.times do |i|
  thread_pool << Thread.new do
    answer = workers[i].calculate
    puts "Worker #{i} finished in #{answer} seconds"
  end # Thread.new
end # NUM_WORKERS.times

# Oczekiwanie
thread_pool.each(&:join)

# Wyłączenie
workers.each { |w| w.stop }



# Worker running at druby://127.0.1.1:7000
# Worker running at druby://127.0.1.1:7001
# Worker running at druby://127.0.1.1:7002
# Worker running at druby://127.0.1.1:7003
# Worker 0 finished in 2 seconds
# Worker 3 finished in 5 seconds
# Worker 1 finished in 5 seconds
# Worker 2 finished in 6 seconds
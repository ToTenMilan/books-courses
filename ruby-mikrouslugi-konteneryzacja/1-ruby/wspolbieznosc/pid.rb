fork_pid = fork do # fork returns process id
  puts "child: my pid is #{$$}"
  puts "child: my parent's pid is #{Process.ppid}"
end
puts "parent: my pid is #{Process.pid}"
puts "parent: my child's pid is #{fork_pid}"

# sent from child process
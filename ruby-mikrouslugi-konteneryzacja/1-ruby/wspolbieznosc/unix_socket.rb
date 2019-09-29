require 'socket'

# two-way communication
parent_socket, child_socket = UNIXSocket.pair
fork do
  parent_socket.close
  child_socket.send("sent from child (#{$$})", 0)
  from_parent = child_socket.recv(100)
  puts from_parent
end # fork
child_socket.close
parent_socket.send("sent from parent (#{$$})", 0)
from_child = parent_socket.recv(100)
puts from_child

# sent from child (15130)
# sent from parent (15129)
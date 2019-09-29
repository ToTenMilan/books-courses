require 'get_process_mem'

N = 4_000_000_000
arr = []
i=0

N.times do
  # pront memory status on every 1000000
  if i % 10_000_000 == 0
    tmp = GetProcessMem.new
    puts tmp.inspect
  end
  # fill memory
  arr << 1
  i+=1
end

# on 4GB VirtualBox
# ...
#<GetProcessMem:0x0150c5c0 @mb=1917.7890625 @gb=1.8728408813476562 @kb=1963816.0 @bytes=0.2010947584e10>
#<GetProcessMem:0x0152f868 @mb=1995.0859375 @gb=1.9483261108398438 @kb=2042968.0 @bytes=0.2091999232e10>
#<GetProcessMem:0x0155ac48 @mb=2071.30859375 @gb=2.0227622985839844 @kb=2121020.0 @bytes=0.217192448e10>
#<GetProcessMem:0x01559eb0 @mb=2146.6328125 @gb=2.0963211059570312 @kb=2198152.0 @bytes=0.2250907648e10>
# Traceback (most recent call last):
# fill.rb: failed to allocate memory (NoMemoryError)
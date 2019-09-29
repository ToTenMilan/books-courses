#*******************************************************************************
# Biblioteki
#*******************************************************************************
require 'benchmark'
load 'sort.rb'
#*******************************************************************************
# Dane
#*******************************************************************************
processes_no = 2
arr_size = 1190
option = ARGV[0].to_s
reader, writer = IO.pipe
$sort_index = 0
arr = Array.new(8*arr_size) { (rand*100000).to_i }
# puts arr.inspect
# puts
#*******************************************************************************
# Przetwarzanie
#*******************************************************************************
puts "MAIN #{$$} => START"
# bubble_sort

if option == 'with-bubble-sort' then
  sorted = nil
  time = Benchmark.realtime do
    sorted = bubble_sort(arr)
    puts "=> bubble_sort"
  end # Benchmark.realtime
  sel_print_sorted_arr(sorted)
  puts 'time=' + time.to_s
  puts
end # if

sleep 1
# quicksort
puts "=> quicksort"
sorted = nil
time2 = Benchmark.realtime do
  arr_size = arr.size
  step  = (arr_size/processes_no)-1
  processes_no.times do |index|
    fork do
      $sort_index = 0
      reader.close
      start = 0
      if index > 0 then start = step*(index)+index end 
      finish = step*(index+1)+index
      res = quicksort(arr[start..finish], 0, step).to_s + '+'
      # puts "#{$$} => " + res.inspect
      puts "#{$$} => before write + #{res.size.to_s}"
      writer.write(res)
      puts "#{$$} => after write"
    end # fork
  end # processes_no.times
  writer.close
  Process.waitall
  pre_sorted = reader.gets
  pre_sorted = pre_sorted + '[]'
  sorted = quicksort(eval(pre_sorted), 0, arr_size-1)
end # Benchmark.realtime

sel_print_sorted_arr(sorted)
puts 'time2=' + time2.to_s
puts "MAIN #{$$} => FINISH"

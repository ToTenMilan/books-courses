#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
require "benchmark"

num_rows = 100000
num_cols = 10
data = Array.new(num_rows) { Array.new(num_cols) { "x"*1000 } }

# puts "%dM" % `ps -o rss= -p #{Process.pid}`.to_i
# time = Benchmark.realtime do
#   csv = data.map do |row|
#     row.join(",")
#   end.join("\n")
# end
# puts "%dM" % `ps -o rss= -p #{Process.pid}`.to_i

# puts time.round(2)  # ~2s
# memory consumption and garbage collection is why ruby is (was) slow
# GC in ruby 2.1 and later is 5x faster

# dont store object in memory, store them on the go
puts "%dM" % `ps -o rss= -p #{Process.pid}`.to_i
time = Benchmark.realtime do
  csv = ''
  num_rows.times do |i|
    num_cols.times do |j|
      csv << data[i][j]
      csv << "," unless j == num_cols - 1
    end
    csv << "\n" unless i == num_rows - 1
  end
end
puts "%dM" % `ps -o rss= -p #{Process.pid}`.to_i

puts time.round(2) # ~1s


######### To remember
# (...) line-by-line data processing and avoiding intermediate objects (...)

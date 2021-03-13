#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
require_relative 'wrapper'
require 'csv'

measure do
  File.read("data.csv")
end

measure do
  File.readlines("data.csv").map! { |line| line.split(",") }
end

measure do
  CSV.read("data.csv")
end

# Above tkaes a lot of memory
# The solution? Read and parse data files line by line as much as possible

measure do
  file = File.open("data.csv", "r")
  while line = file.gets
    line.split(",")
  end
end

measure do
  file = CSV.open("data.csv")
  while line = file.readline
  end
end

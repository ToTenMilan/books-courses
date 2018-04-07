def for_each_element(array)
  i = 0
  while i < array.length
    yield(array[i])
    i += 1
  end
end

a = [1,2,3,54,5]
for_each_element(a) { |e| puts "the elemenet is #{e}"}

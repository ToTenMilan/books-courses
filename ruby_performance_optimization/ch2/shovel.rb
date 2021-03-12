require_relative 'wrapper'

times = 100000
y = 'x'
x = 'x'
measure do
  times.times do
    y += 'x'
  end
end
measure do
  times.times do
    x += 'x'
  end
end

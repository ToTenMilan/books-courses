def my_method
  x = 'goodbye' # this 'x' is not seen by created block below
  yield('cruel') # 'cruel' will be yielded to the cretaed block
end

x = 'hello' # this 'x' will be captured by created block below
my_method { |y| "#{x} #{y} world"} # here block is created
def explore_array(method, *arguments)
  ['a', 'b', 'c'].send(method, *arguments)
end

loop { p explore_array(gets.chomp()) }
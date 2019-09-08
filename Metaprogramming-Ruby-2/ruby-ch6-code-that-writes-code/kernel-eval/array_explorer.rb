def explore_array(method)
  code = "%w[a b c].#{method}"
  puts "evaluating #{code}"
  eval code
end

# when published, malicious code could be executed after any array method. I.e `reverse; Dir.glob("*")`
loop { p explore_array(gets()) }
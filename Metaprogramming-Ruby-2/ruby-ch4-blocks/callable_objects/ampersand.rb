def math(a, b)
  yield(a, b)
end

def do_math(a, b, &operation) # '&' converts passed block to a proc (only pass, dont execute)
  math(a, b, &operation) # '&' converts proc to block (execute as 'math(a, b) { ... })
end

p do_math(2,3) { |x, y| x * y } # this block will be converted to proc by '&' in method definition





def meth(&the_proc) # passed block will be converted to Proc
  the_proc # the_proc is 'Proc' object
end

pr = meth { |name| "hello #{name}"}
pr.class
pr.call("Joshua")
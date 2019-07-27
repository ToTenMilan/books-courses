def meth(greeting)
  "#{greeting}, #{yield}"
end

my_proc = proc { "Bill" } # only save block in variable, as a proc
p meth("Hello", &my_proc) # when called, '&' converts proc to block so:
# meth('hello', &my_proc) --becomes--> meth('hello') { 'Bill' }
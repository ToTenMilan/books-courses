# before set
# $ export RUBY_THREAD_VM_STACK_SIZE=100000

def factorial(n)
  raise InvalidArgument, "negative input given" if n < 0
  return 1 if n == 0
  return factorial(n - 1) * n
end # factorial
(1..5000).each do |index|
  puts factorial(index).to_s.size
end # each


# ...
# 2740
# 2743
# 2746
# 2749
# 2752
# Traceback (most recent call last):
# 	1064: from factorial.rb:9:in `<main>'
# 	1063: from factorial.rb:9:in `each'
# 	1062: from factorial.rb:10:in `block in <main>'
# 	1061: from factorial.rb:7:in `factorial'
# 	1060: from factorial.rb:7:in `factorial'
# 	1059: from factorial.rb:7:in `factorial'
# 	1058: from factorial.rb:7:in `factorial'
# 	1057: from factorial.rb:7:in `factorial'
# 	 ... 1052 levels...
# 	   4: from factorial.rb:7:in `factorial'
# 	   3: from factorial.rb:7:in `factorial'
# 	   2: from factorial.rb:7:in `factorial'
# 	   1: from factorial.rb:7:in `factorial'
# factorial.rb:7:in `factorial': stack level too deep (SystemStackError)
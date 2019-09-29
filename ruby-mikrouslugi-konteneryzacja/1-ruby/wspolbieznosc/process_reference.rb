require "./process_lib"
require "benchmark"

puts Benchmark.measure {
  100.times do |i|
    Mailer.deliver do 
      from    "nadawca"
      to      "adresat"
      subject "Threading and Forking (#{i})"
      body    "Some content"
    end # Mailer.deliver
  end # 100.times
} # Benchmark.measure

############# Sequential ####################
# ...
# Subject   : Threading and Forking (90)
# Body      : Some content
# Email from: nadawca
# Email to  : adresat
# Subject   : Threading and Forking (91)
# Body      : Some content
# Email from: nadawca
# Email to  : adresat
# Subject   : Threading and Forking (92)
# Body      : Some content
# Email from: nadawca
# Email to  : adresat
# Subject   : Threading and Forking (93)
# Body      : Some content
# Email from: nadawca
# Email to  : adresat
# Subject   : Threading and Forking (94)
# Body      : Some content
# Email from: nadawca
# Email to  : adresat
# Subject   : Threading and Forking (95)
# Body      : Some content
# Email from: nadawca
# Email to  : adresat
# Subject   : Threading and Forking (96)
# Body      : Some content
# Email from: nadawca
# Email to  : adresat
# Subject   : Threading and Forking (97)
# Body      : Some content
# Email from: nadawca
# Email to  : adresat
# Subject   : Threading and Forking (98)
# Body      : Some content
# Email from: nadawca
# Email to  : adresat
# Subject   : Threading and Forking (99)
# Body      : Some content
#  28.904741   0.000000  28.904741 ( 30.824552)


# PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND                                                          
#  9599 milan     20   0   87532  13764   5088 R 98,0  0,3   0:04.10 ruby                                                             
#  4604 milan     20   0  575084  32156  24056 S  0,7  0,8   0:03.89 gnome-terminal-                                                  
#  1012 root      20   0  397664  83564  31360 S  0,3  2,1   0:22.09 Xorg                                                             
#  4173 milan     20   0 1107824 230540  92076 S  0,3  5,7   1:49.64 code                                                             
#  4411 milan     20   0  732212 274680   9852 S  0,3  6,8   0:47.88 ruby
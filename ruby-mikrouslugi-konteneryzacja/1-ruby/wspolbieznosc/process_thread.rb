 
require "./process_lib"
require "benchmark"

threads = []
puts Benchmark.measure {
  100.times do |i|
    # uruchamianie nowego wątku (w ramach istniejącego procesu)
    threads << Thread.new do     
      Mailer.deliver do 
        from    "nadawca"
        to      "adresat"
        subject "Threading and Forking (#{i})"
        body    "Some content"
      end # Mailer.deliver
    end # Thread.new
  end # 100.times
  threads.map(&:join)
} # Benchmark.measure

########################### MULTITHREAD ################################
# ...
# Subject   : Threading and Forking (70)
# Body      : Some content
# Email from: nadawca
# Email to  : adresat
# Subject   : Threading and Forking (22)
# Body      : Some content
# Email from: nadawca
# Email to  : adresat
# Subject   : Threading and Forking (41)
# Body      : Some content
# Email from: nadawca
# Email to  : adresat
# Subject   : Threading and Forking (61)
# Body      : Some content
# Email from: nadawca
# Email to  : adresat
# Subject   : Threading and Forking (40)
# Body      : Some content
# Email from: nadawca
# Email to  : adresat
# Subject   : Threading and Forking (3)
# Body      : Some content
# Email from: nadawca
# Email to  : adresat
# Subject   : Threading and Forking (86)
# Body      : Some content
#  28.868933   0.007785  28.876718 ( 29.010802)



########### `top` output ######################## 
# note single process, (multi threads)
#
# PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND                                                          
# 9286 milan     20   0  632120  13836   5160 S 99,3  0,3   0:08.39 ruby                                                             
# 4411 milan     20   0  732212 269400   9852 S  0,3  6,7   0:46.28 ruby                                                             
# 7905 milan     20   0  742224 122780  77980 S  0,3  3,0   0:02.24 chrome                                                           
#    1 root      20   0  119680   5712   3900 S  0,0  0,1   0:01.24 systemd                                                          
#    2 root      20   0       0      0      0 S  0,0  0,0   0:00.00 kthreadd
require "./process_lib"
require "benchmark"
puts Benchmark.measure {
  100.times do |i|
    # uruchamianie nowego procesu
    fork do     
      Mailer.deliver do 
        from    "nadawca"
        to      "adresat"
        subject "Threading and Forking (#{i})"
        body    "Some content"
      end # Mailer.deliver
    end # fork
  end # 100.times
  Process.waitall
} # Benchmark.measure

################# MULTIPROCESS ###############################
# ...
# Email to  : adresat
# Subject   : Threading and Forking (95)
# Body      : Some content

# Email to  : adresat
# Email to  : adresat
# Subject   : Threading and Forking (90)
# Subject   : Threading and Forking (94)
# Body      : Some content
# Body      : Some content

# Email from: nadawca
# Email to  : adresat
# Subject   : Threading and Forking (89)
# Email to  : adresat
# Body      : Some content
# Subject   : Threading and Forking (85)

# Body      : Some content

# Email to  : adresat
# Subject   : Threading and Forking (97)
# Email to  : adresat
# Body      : Some content

# Subject   : Threading and Forking (98)
# Body      : Some content

# Email to  : adresat
# Subject   : Threading and Forking (96)
# Body      : Some content

# Email to  : adresat
# Subject   : Threading and Forking (99)
# Body      : Some content
#   0.001377   0.022514  29.326951 ( 30.052050)



########### `top` output ########################
# note multi processes
#
# PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND                                                          
# 9117 milan     20   0   87532  10936   2020 R  1,2  0,3   0:00.29 ruby                                                             
# 9129 milan     20   0   87532  10936   2020 R  1,2  0,3   0:00.28 ruby                                                             
# 9131 milan     20   0   87532  10936   2020 R  1,2  0,3   0:00.28 ruby                                                             
# 9139 milan     20   0   87532  10936   2020 R  1,2  0,3   0:00.28 ruby                                                             
# 9142 milan     20   0   87532  10936   2020 R  1,2  0,3   0:00.28 ruby                                                             
# 9145 milan     20   0   87532  10936   2020 R  1,2  0,3   0:00.28 ruby                                                             
# 9154 milan     20   0   87532  10936   2020 R  1,2  0,3   0:00.28 ruby                                                             
# 9155 milan     20   0   87532  10936   2020 R  1,2  0,3   0:00.28 ruby                                                             
# 9156 milan     20   0   87532  10936   2020 R  1,2  0,3   0:00.28 ruby
# ....
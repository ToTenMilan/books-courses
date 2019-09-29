N = 10_000_000
i = 0
arr = []
option = ARGV[0].to_i

if option == 1 then
  N.times do
    arr << 1 # 11.268415397999888
  end
elsif option == 2
  N.times do  
    arr[(i+=1)] = 1 # 18.42434546700042 
  end
elsif option == 3
  N.times do    
    i+=1
    arr[i] = 1 # 19.995176096998875
  end
elsif option == 4
  N.times do    
    arr.push(1) # 11.710160142001769
  end
end
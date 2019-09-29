require 'MyClass'
camera_x =  200
camera_y =  335
camera_z = -250
start_x =   250
start_y =    40
start_z =   150
th_x    =     0
th_y    =     0
th_z    =     0
x       = 100 + start_x
y       = 100 + start_y
z       = 100 + start_z
m = MyClass.new
10.times do |i|
  arr =  m.transform3Into2(x,y,z, camera_x,camera_y,camera_z, th_x,th_y,th_z)
  puts arr.class.to_s + " => #{arr[0]} x #{arr[1]}"
end # times
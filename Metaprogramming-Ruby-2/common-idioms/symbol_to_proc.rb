# step 1
names = [​'bob'​, ​'bill'​, ​'heather'​]
names.map {|name| name.capitalize }   ​# => ["Bob", "Bill", "Heather"]

# ​class​ Symbol
#   ​def​ to_proc
#     Proc.new {|x| x.send(self) }
#   ​end​
# ​end

# step 2
names = [​'bob'​, ​'bill'​, ​'heather'​]
names.map(&:capitalize.to_proc)   ​# => ["Bob", "Bill", "Heather"]

# step 3
names = [​'bob'​, ​'bill'​, ​'heather'​]
# apply `&` to ANY object, and it will convert it to proc
names.map(&:capitalize)   ​# => ["Bob", "Bill", "Heather"]




# without Symbol#to_proc:​
[1, 2, 5].inject(0) {|memo, obj| memo + obj }   ​# => 8​

​# with Symbol#to_proc:​
[1, 2, 5].inject(0, &:+)  ​# => 8​
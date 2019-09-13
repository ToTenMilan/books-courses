# train wreck? debugging problem is how to debug `shift`
[​'a'​, ​'b'​, ​'c'​].push(​'d'​).shift.upcase.next ​# => "B"

# debugging like this is time consuming
temp = [​'a'​, ​'b'​, ​'c'​].push(​'d'​).shift
puts temp
x = temp.upcase.next

# better use `tap`
[​'a'​, ​'b'​, ​'c'​].push(​'d'​).shift.tap {|x| puts x }.upcase.next


class​ Object
  ​def​ tap
    ​yield​ self
    self
  ​end​
​end
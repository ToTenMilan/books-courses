module M
  def self.included(c)
    puts "Module #{self} was included by class #{c}"
  end
  def self.extended(obj)
    puts "Module #{self} was extended by obj #{obj}"
  end
end

class Z
end

obj = Object.new
puts 'inluding module M do singleton objects class of given object'
class << obj
  include M
end
puts
obj = Object.new
puts "extending of object by module M"
obj.extend(M)

# inluding module M do singleton objects class of given object
# Module M was included by class #<Class:#<Object:0x0000000000d1cc70>>

# extending of object by module M
# Module M was extended by obj #<Object:0x0000000000d1ca18>

puts
obj = Object.new
puts "extending of Z by module M"
Z.extend(M)

# extending of Z by module M
# Module M was extended by obj Z

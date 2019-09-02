s1, s2 = 'foo', 'bar'

s1.instance_eval do
  def swoosh!; reverse; end
end

p s1.swoosh! # => 'cba'
p s1.respond_to?(:swoosh!) # => true
p s2.respond_to?(:swoosh!) # => false
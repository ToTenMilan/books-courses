module M
  def self.append_features(base)
  end
end

class C
  include M
end

# M should be in ancestors
p C.ancestors # => [C, Object, Kernel, BasicObject] 

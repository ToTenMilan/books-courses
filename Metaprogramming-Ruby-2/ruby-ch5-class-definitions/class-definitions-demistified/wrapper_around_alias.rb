class String
  alias_method :real_length, :length

  def length
    real_length > 5 ? 'long' : 'short'
  end
end

p "sdf sljf lsdj lksd".length
p "lskdl lskdjf lk sdfl".real_length
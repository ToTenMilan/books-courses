module M1
  def self.included(includer)
    puts "M1 was included into #{includer}"
  end
end

module M2
  def self.prepended(prepender)
    puts "M2 was prepended to #{prepender}"
  end
end

class C
  include M1
  prepend M2
end

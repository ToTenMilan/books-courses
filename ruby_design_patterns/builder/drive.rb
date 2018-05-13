class Drive
  attr_reader :type, :size, :writeable

  def initialize(type, size, writable)
    @type, @size, @writable = type, size, writable
  end
end

class LaptopDrive < Drive

end
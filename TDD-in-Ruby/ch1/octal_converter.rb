class OctalConverter
  def initialize(number)
    @number = number
  end

  def convert
    # octal = []
    # if @number < 8
    #   octal << @number
    # else
    #   until @number == 0
    #     remainder = @number % 8
    #     @number = @number / 8
    #     octal.unshift(remainder)
    #   end
    # end
    # octal

    octal = []
    until finished?
      digit = extract_octal_digit
      reduce
      octal.unshift(digit)
    end
    octal
  end

  private

  def extract_octal_digit
    @number % 8
  end

  def reduce
    @number = @number / 8
  end

  def finished?
    @number == 0
  end
end

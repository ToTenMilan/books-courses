require 'minitest/autorun'

class String
  def vowel?
    %(a e i o u).include?(self)
  end
end

module MiniTest::Assertions
  def assert_vowel(letter)
    assert(%(a e i o u).include?(letter), "Expected #{letter} to be a vowel")
  end

  def data_driven_test(container)
    container.each do |element|
      yield element
    end
  end
end

# describe 'Vowel Checker' do
#   %w(a e i o u).each do |letter|
#     it "#{letter} is a vowel" do
#       assert_vowel letter
#     end
#   end
# end

describe 'Vowel Checker' do
  it "a, e, i, o, u are the vowel set" do
    data_driven_test(%w(a e i o u)) do |letter|
      assert_vowel letter
    end
    # %w(a e i o u).each do |letter|
    #   assert_vowel(letter)
    # end
  end
end

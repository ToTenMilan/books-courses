#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
class Water
  def self.elements
    [:oxygen, :hydrogen]
  end
end

RSpec.describe Water do
  it 'is H2O' do
    # expect(Water.elements.sort).to eq [:hydrogen, :hydrogen, :oxygen]
    ##### Currently expectation just dumps data to compare to by yourself. Make it compare the data for you and show differences
    expect(Water.elements.sort).to contain_exactly :hydrogen, :hydrogen, :oxygen
  end
end
Sandwich = Struct.new(:taste, :toppings)

RSpec.describe 'An ideal sandwich' do
  def sandwich
    Sandwich.new('delicious', [])
  end

  it 'is delicious' do
    taste = sandwich.taste
    expect(taste).to eq('delicious')
  end

  it 'lets me add toppings' do
    sandwich.toppings << 'cheese' # create sandwich
    toppings = sandwich.toppings # create another sandwich (not refer earlier sandwich)
    expect(toppings).not_to be_empty
  end
end
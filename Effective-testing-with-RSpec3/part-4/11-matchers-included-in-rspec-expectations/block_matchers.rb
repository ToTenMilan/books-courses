def just_yield
  yield
end

RSpec.describe 'block matchers' do
  it 'check yield' do
    expect { |block_checker| just_yield(&block_checker) }.to yield_control
  end

  it '' do
    x = 5
    expect { x += 10 }.to change { x }
      .from(a_value_between(2,7))
      .to(a_value_between(12, 17))
  end
end



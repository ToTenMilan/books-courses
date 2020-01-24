RSpec.configure do |c|
  # bad -> for development
  # good -> for CI (if so, consider task imitating tests on CI)
  c.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end
end

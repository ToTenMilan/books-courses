RSpec.shared_examples 'URI parser' do |parser_class|
  let(:parser) { parser_class }

  it 'parses the port' do
    expect(parser.parse('http://example.com:9876').port).to eq 9876
  end

  it 'parses the host' do
    expect(parser.parse('http://example.com/').host).to eq 'example.com'
  end
end
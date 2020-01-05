require 'uri'
require_relative './uri_parser_shared_examples'

RSpec.describe URI do
  it_behaves_like 'URI parser', URI
  # describe '#host' do
  #   it 'parses the host' do
  #     # expect(URI.parse('http://example.com/').host).to eq 'example.com'
  #     it_behaves_like 'URI parser'
  #   end
  # end

  describe '#port' do
    # it 'parses the port' do
    #   # expect(URI.parse('http://example.com:9876').port).to eq 9876
    #   it_behaves_like 'URI parser', URI
    # end

    it 'parses the port for an http URI to 80' do
      expect(URI.parse('http://example.com/').port).to eq 80
    end

    it 'parses the host' do
      expect(URI.parse('https://example.com/').port).to eq 443
    end
  end
end

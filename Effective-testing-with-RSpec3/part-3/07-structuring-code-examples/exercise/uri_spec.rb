require 'uri'
require_relative './uri_parser_shared_examples'

RSpec.describe URI do
  it_behaves_like 'URI parser', URI

  describe '#port' do
    it 'parses the port for an http URI to 80' do
      expect(URI.parse('http://example.com/').port).to eq 80
    end

    it 'parses the host' do
      expect(URI.parse('https://example.com/').port).to eq 443
    end
  end
end

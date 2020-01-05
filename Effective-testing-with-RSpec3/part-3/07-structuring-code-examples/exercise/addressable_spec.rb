require 'addressable'
require_relative './uri_parser_shared_examples'

RSpec.describe Addressable::URI do
  it_behaves_like 'URI parser', Addressable::URI
  
  it 'parses the scheme' do
    expect(Addressable::URI.parse('https://example.com/').scheme).to eq 'https'
  end

  it 'parses the path' do
    expect(Addressable::URI.parse('https://example.com/foo').path).to eq '/foo'
  end
end

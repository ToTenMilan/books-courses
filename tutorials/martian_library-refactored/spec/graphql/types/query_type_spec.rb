require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'items' do
    let!(:items) { create_pair(:item) }
    let(:query) do
      %(query {
        items {
          title
        }
      })
    end

    subject(:result) do
      MartianLibrarySchema.execute(query).as_json
    end

    it 'returns all items' do
      result_to_compare = items.map { |item| { 'title' => item.title }}
      pp result_to_compare # => [{"title"=>"item-1"}, {"title"=>"item-2"}]
      expect(result.dig('data', 'items')).to match_array(
        result_to_compare
      )
    end
  end
end
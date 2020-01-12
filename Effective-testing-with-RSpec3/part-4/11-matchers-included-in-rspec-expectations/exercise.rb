#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---

class PhoneNumberExtractor
  def self.extract_from(text, &block)
    # Look for patterns like (###) ###-####
    text.scan(/\(\d{3}\) \d{3}-\d{4}/, &block)
  end
end

RSpec.describe PhoneNumberExtractor do
  let(:text) do
    <<-EOS
      Melinda: (202) 555-0168
      Bob: 202-555-0199
      Sabina: (202) 555-0176
    EOS
  end

  it 'yields phone numbers as it finds them' do
    # yielded_numbers = []
    # PhoneNumberExtractor.extract_from(text) do |number|
    #   yielded_numbers << number
    # end

    # expect(yielded_numbers).to eq [
    #   '(202) 555-0168',
    #   '(202) 555-0175'
    # ]
    ##### make above "block" checking":
    expect { |block_checker| PhoneNumberExtractor.extract_from(text, &block_checker) }
      .to yield_control.twice
  end
end



PublicCompany = Struct.new(:name, :value_per_share, :share_count) do
  def got_better_than_expected_revenues
    self.value_per_share *= rand(1.05..1.10)
  end

  def market_cap
    @market_cap = value_per_share * share_count
  end
end

RSpec.describe PublicCompany do
  let(:company) { PublicCompany.new('Nil', 10, 100_000) }

  it 'increases its market cap when it gets better than expected revenues' do
    before_market_cap = company.market_cap
    company.got_better_than_expected_revenues
    
    after_market_cap = company.market_cap
    # expect(after_market_cap - before_market_cap).to be >= 50_000
    ##### make above more readable:
    expect(after_market_cap - before_market_cap).to match a_value_between(50_000, 100_000)
  end

  it 'provides attributes' do
    # expect(company.name).to eq('Nil')
    # expect(company.value_per_share).to eq(10)
    # expect(company.share_count).to eq(100_000)
    # expect(company.market_cap).to eq(1_000_000)
    expect(company).to have_attributes(
      name: 'Nile',
      value_per_share: 10,
      share_count: 100_000,
      market_cap: 1_000_000
    )
  end
end

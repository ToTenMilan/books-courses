class Invoice
  def initialize(address, items, tax_client: MyApp.tax_client)
    @address = address
    @items = items
    @tax_client = tax_client
  end

  def calculate_total
    subtotal = @items.map(&:cost).inject(0, :+)
    taxes = subtotal * tax_rate
    subtotal + taxes
  end

  private

  def tax_rate
    @tax_client.rates_for_location(@address.zip).combined_rate
  end
end


RSpec.describe Invoice do
  let(:address) { Address.new(zip: '90210') }
  let(:items) { [Item.new(cost: 30), Item.new(cost: 70)] }

  it 'calculates the total' do
    tax_rate = instance_double(Taxjar::Rate, combined_rate: 0.095) # mock tax_rate...
    tax_client = instance_double(Taxjar::Client, rates_for_location: tax_rate) # to mock tax-double

    invoice = Invoice.new(address, items, tax_client: tax_client)

    expect(invoice.calculate_total).to eq(109.50)
  end
end

# drawbacks:
# The Invoice class is tightly coupled to the TaxJar client’s object hierarch
# The complexity will make refactoring and maintenance more difficult



### Better approach
# we may write SalesTax wrapper to decouple Invoice from Taxjar
# we accept that underlying API may change, and only whis class would need to change then
class SalesTax
  RateUnavailableError = Class.new(StandardError)

  def initialize(tax_client = MyApp.tax_client)
    @tax_client = tax_client
  end

  def rate_for(zip)
    @tax_client.rates_for_location(zip).combined_rate
  rescue Taxjar::Error::NotFound
    raise RateUnavailableError, "Sales tax rate unavailable for zip: #{zip}"
  end
end

# new Invoice, that needs wrapper of TaxJar instead of TaxJar itself
class Invoice
  def initialize(address, items, sales_tax: SalesTax.new)
    @address = address
    @items = items
    @sales_tax = sales_tax
  end

  def calculate_total
    subtotal = @items.map(&:cost).inject(0, :+)
    taxes = subtotal * tax_rate
    subtotal + taxes
  end

private

  def tax_rate
    @sales_tax.rate_for(@address.zip)
  end
end

# ... also specs are simpler
RSpec.describe Invoice do
  let(:address) { Address.new(zip: '90210') }
  let(:items) { [Item.new(cost: 30), Item.new(cost: 70)] }

  it 'calculates the total' do
    sales_tax = instance_double(SalesTax, rate_for: 0.095)

    invoice = Invoice.new(address, items, sales_tax: sales_tax)

    expect(invoice.calculate_total).to eq(109.50)
  end
end

# to detect changes in TaxJar API
RSpec.describe SalesTax do
  let(:sales_tax) { SalesTax.new }

  it 'can fetch the tax rate for a given zip' do
    rate = sales_tax.rate_for('90210')
    expect(rate).to be_a(Float).and be_between(0.01, 0.5)
  end

  it 'raises an error if the tax rate cannot be found' do
    expect {
      sales_tax.rate_for('00000')
    }.to raise_error(SalesTax::RateUnavailableError)
  end
end

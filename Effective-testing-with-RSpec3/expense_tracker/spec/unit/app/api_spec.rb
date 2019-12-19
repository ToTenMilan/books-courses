require_relative '../../../app/api'
require 'rack/test'

module ExpenseTracker
  RSpec.describe API do
    include Rack::Test::Methods

    def app
      API.new(ledger: ledger)
    end

    let(:ledger) { instance_double('ExpenseTracker::Ledger') } # class Ledger dont exist at the point of this writing
    
    describe "POST /expenses" do
      context 'when the expense is successfully recorded' do
        # mock 'Ledger' to test ONLY the route and what it returns, not models it uses underneath
        let(:expense) { { 'some' => 'data' } }
        before do
          allow(ledger).to receive(:record).with(expense).and_return(RecordResult.new(true, 417, nil)) # imitate app logic, return succes response no matter the input
        end
        it "returns the expense id" do
          post '/expenses', JSON.generate(expense)
          expect(json_response).to include('expense_id' => 417)
        end
        it "responds with 200 (OK)" do
          post '/expenses', JSON.generate(expense)
          expect(last_response.status).to eq(200)
        end
      end

      context "when the expense fails validation" do
        let(:expense) { { 'some' => 'data' } }
        before do
          allow(ledger).to receive(:record).with(expense).and_return(RecordResult.new(false, 417, 'Expense Incomplete'))
        end
        it 'returns an error message' do
          post '/expenses', JSON.generate(expense)
          expect(json_response).to include('error' => 'Expense Incomplete')
        end
        it 'responds with a 422 (Unprocessable Entity)' do
          post '/expenses', JSON.generate(expense)
          expect(last_response.status).to eq(422)
        end
      end
    end

    describe 'GET /expenses/:date' do
      context 'when expenses exist on given date' do
        let(:date) { 'not_important' } # not important becaue we do not test the implementation of Ledger#expenses_on
        let(:coffee) {{ # data not important
          'payee' => 'Starbucks',
          'amount' => 5.75,
          'date' => '2017-06-10'
        }}
        let(:zoo) {{ # data not important
          'payee' => 'Zoo',
          'amount' => 15.25,
          'date' => '2017-06-10'
        }}
        before do
          allow(ledger).to receive(:expenses_on).with(date).and_return( [ coffee, zoo ] ) # mock the object and logic in its methods
        end
        it 'returns the expense records as JSON' do
          get "expenses/#{date}"
          expect(json_response).to include( coffee, zoo )
        end
        it 'responds with a 200' do
          get "expenses/#{date}"
          expect(last_response.status).to be 200
        end
      end

      context 'when there are no expenses on the given date' do
        let(:date) { 'not_important' }
        before do
          allow(ledger).to receive(:expenses_on).with(date).and_return([]) # mock the object and logic in its methods
        end
        it 'returns an empty array as JSON' do
          get "/expenses/#{date}"
          expect(json_response).to eq []
        end
        it 'responds with a 200 (OK)' do
          get "/expenses/#{date}"
          expect(last_response.status).to be 200
        end
      end
    end
  end
end

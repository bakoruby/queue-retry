require 'account_aggregator'

RSpec.describe AccountAggregator do
  describe '.get_balance' do
    it 'retrieves the account balance' do
      aggregator = AccountAggregator.new(1234)

      aggregator.get_balance

      expect(aggregator.balance).to eq(85660508.06)
    end

    it 'should be valid if all sources are valid' do
      aggregator = AccountAggregator.new(1234)

      aggregator.get_balance

      expect(aggregator).to be_valid
    end

    it 'should be invalid if any source is invalid' do
      aggregator = AccountAggregator.new(1234)
      stub_request(:get, "brokerage.example.com").
        to_raise("Splat")

      aggregator.get_balance

      expect(aggregator).not_to be_valid
    end
  end
end

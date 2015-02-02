require 'pry'
require 'account_aggregator'

RSpec.describe AccountAggregator do
  describe '.get_balance' do
    it 'retrieves the account balance' do
      aggregator = AccountAggregator.new(1234)

      aggregator.get_balance

      expect(aggregator.balance).to eq(85660508.06)
    end
  end
end

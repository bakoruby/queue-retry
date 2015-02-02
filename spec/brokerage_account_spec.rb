require 'spec_helper'
require 'brokerage_account'

describe BrokerageAccount do
  describe '.call' do
    it 'fetches the balance from the service' do
      client = BrokerageAccount.new(1234)

      client.call

      expect(client.balance).to eq(3209123.23)
    end
  end
end

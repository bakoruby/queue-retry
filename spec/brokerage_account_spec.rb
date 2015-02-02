require 'spec_helper'
require 'brokerage_account'

describe BrokerageAccount do
  describe '.call' do
    it 'fetches the balance from the service' do
      client = BrokerageAccount.new(1234)

      client.call

      expect(client.balance).to eq(3209123.23)
    end

    it 'should be valid if the call succeeds' do
      client = BrokerageAccount.new(1234)

      client.call

      expect(client).to be_valid
    end

    it 'should be invalid if the call fails' do
      stub_request(:get, "brokerage.example.com").
        to_raise("Splat")
      client = BrokerageAccount.new(1234)

      client.call

      expect(client).not_to be_valid
      expect(client.error.message).to eq('Splat')
    end

    it 'should retry 3 times' do
      stub_request(:get, "brokerage.example.com").
        to_raise("Splat").
        to_raise("Chunk").
        to_return(:body => "{\"balance\":238723.22}")
      client = BrokerageAccount.new(1234, 3)

      client.call

      expect(client).to be_valid
      expect(client.balance).to eq(238723.22)
    end
  end
end

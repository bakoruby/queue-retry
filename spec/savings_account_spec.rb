require 'savings_account'

describe SavingsAccount do
  describe '.call' do
    it 'fetches the balance from the service' do
      client = SavingsAccount.new(1234)

      client.call

      expect(client.balance).to eq(76123763.21)
    end

    it 'should be valid if the call succeeds' do
      client = SavingsAccount.new(1234)

      client.call

      expect(client).to be_valid
    end

    it 'should be invalid if the call fails' do
      stub_request(:get, "savings.example.com").
        to_raise("Splat")
      client = SavingsAccount.new(1234)

      client.call

      expect(client).not_to be_valid
      expect(client.error.message).to eq('Splat')
    end

    it 'should retry 3 times' do
      stub_request(:get, "savings.example.com").
        to_raise("Splat").
        to_raise("Chunk").
        to_return(:body => "{\"balance\":65182.23}")
      client = SavingsAccount.new(1234, 3)

      client.call

      expect(client).to be_valid
      expect(client.balance).to eq(65182.23)
    end
  end
end

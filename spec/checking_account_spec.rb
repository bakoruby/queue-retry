require 'checking_account'

describe CheckingAccount do
  describe '.call' do
    it 'fetches the balance from the service' do
      client = CheckingAccount.new(1234)

      client.call

      expect(client.balance).to eq(6327621.62)
    end

    it 'should be valid if the call succeeds' do
      client = CheckingAccount.new(1234)

      client.call

      expect(client).to be_valid
    end

    it 'should be invalid if the call fails' do
      stub_request(:get, "checking.example.com").
        to_raise("Splat")
      client = CheckingAccount.new(1234)

      client.call

      expect(client).not_to be_valid
      expect(client.error.message).to eq('Splat')
    end

    it 'should retry 2 times' do
      stub_request(:get, "checking.example.com").
        to_raise("Splat").
        to_raise("Chunk").
        to_return(:body => "{\"balance\":655231.43}")
      client = CheckingAccount.new(1234, 2)

      client.call

      expect(client).to be_valid
      expect(client.balance).to eq(655231.43)
    end

    it 'should be invalid if it cannot be successful in the amount of retries' do
      stub_request(:get, "checking.example.com").
        to_raise("Splat").
        to_raise("Chunk").
        to_return(:body => "{\"balance\":238723.22}")
      client = CheckingAccount.new(1234, 1)

      client.call

      expect(client).not_to be_valid
    end
  end
end

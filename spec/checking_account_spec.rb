require 'checking_account'

describe CheckingAccount do
  describe '.call' do
    it 'fetches the balance from the service' do
      client = CheckingAccount.new(1234)

      client.call

      expect(client.balance).to eq(6327621.62)
    end
  end
end

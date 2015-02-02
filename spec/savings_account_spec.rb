require 'savings_account'

describe SavingsAccount do
  describe '.call' do
    it 'fetches the balance from the service' do
      client = SavingsAccount.new(1234)

      client.call

      expect(client.balance).to eq(76123763.21)
    end
  end
end

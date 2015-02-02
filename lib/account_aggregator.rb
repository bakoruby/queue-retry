require_relative 'brokerage_account'
require_relative 'savings_account'
require_relative 'checking_account'

class AccountAggregator
  attr_reader :balance

  def initialize(account_number)
    @account_number = account_number
    @balance = 0
  end

  def get_balance
    account_balance_sources.each do |source|
      source_instance = source.new(@account_number)
      source_instance.call
      @balance += source_instance.balance
    end
  end

  private

  def account_balance_sources
    [BrokerageAccount, SavingsAccount, CheckingAccount]
  end

end

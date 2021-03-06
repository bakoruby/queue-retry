require 'thread'
require 'bigdecimal/util'
require_relative 'brokerage_account'
require_relative 'savings_account'
require_relative 'checking_account'

class AccountAggregator
  attr_reader :balance

  def initialize(account_number)
    @account_number = account_number
    @balance = 0
    @queue = Queue.new
    register_queue
  end

  def get_balance
    process_queue
  end

  def valid?
    account_balance_sources.inject(true) do |result, source|
      result && source.valid?
    end
  end

  private

  def register_queue
    account_balance_sources.each do |source|
      @queue.enq(source)
    end
  end

  def process_queue
    workers = (0..2).map do
      Thread.new do
        begin
          while source = @queue.deq(true)
            source.call
            @balance += source.balance.to_d
          end
        rescue ThreadError
        end
      end
    end
    workers.map(&:join)
  end

  def account_balance_sources
    @sources ||= [BrokerageAccount.new(@account_number),
      SavingsAccount.new(@account_number),
      CheckingAccount.new(@account_number)]
  end

end

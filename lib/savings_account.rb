require 'net/http'
require 'json'
require 'retryable'

class SavingsAccount
  include Retryable
  attr_reader :balance, :error

  def initialize(account_number, retries=2)
    @account_number = account_number
    @balance = 0
    @valid = false
    @retries = retries
  end

  def call
    fetch_results
    @valid = true
  rescue => e
    @error = e
  end

  def valid?
    @valid
  end

  private

  def fetch_results
    perform_retry @retries do
      result = JSON.parse(request)
      @balance = result["balance"]
    end
  end

  def request
    Net::HTTP.get(URI("http://savings.example.com"))
  end
end

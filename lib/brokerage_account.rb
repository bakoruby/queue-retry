require 'net/http'
require 'json'

class BrokerageAccount
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
    result = JSON.parse(request)
    @balance = result["balance"]
  rescue => e
    @retries -= 1
    puts e.message
    raise if @retries < 0
    retry
  end

  def request
    Net::HTTP.get(URI("http://brokerage.example.com"))
  end
end

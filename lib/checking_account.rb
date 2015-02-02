require 'net/http'
require 'json'

class CheckingAccount
  attr_reader :balance

  def initialize(account_number)
    @account_number = account_number
  end

  def call
    fetch_results
  end

  private

  def fetch_results
    result = JSON.parse(request)
    @balance = result["balance"]
  end

  def request
    Net::HTTP.get(URI("http://checking.example.com"))
  end
end

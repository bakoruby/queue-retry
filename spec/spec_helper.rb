require 'pry'
require 'webmock/rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do
    stub_request(:get, "brokerage.example.com").
      to_return(:body => lambda { |request| sleep 2; "{\"balance\":3209123.23}" })

    stub_request(:get, "savings.example.com").
      to_return(:body => lambda { |request| sleep 2; "{\"balance\":76123763.21}"})

    stub_request(:get, "checking.example.com").
      to_return(:body => lambda { |request| sleep 2; "{\"balance\":6327621.62}"})

  end
end

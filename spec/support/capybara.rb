# Configure Capybara for system tests
require 'capybara/rails'
require 'capybara/rspec'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    # Use rack_test driver in CI environment where Chrome may not be available
    if ENV['CI'].present?
      driven_by :rack_test
    else
      driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
    end
  end
end

# Database cleaner configuration for tests
require 'database_cleaner/active_record'

RSpec.configure do |config|
  config.before(:suite) do
    # Disable safeguards for CI environment
    DatabaseCleaner.allow_remote_database_url = true if ENV['CI']
    
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

require 'rspec'
require 'vcr'
require_relative '../lib/wunderground'


VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.default_cassette_options = { record: :new_episodes }
  config.filter_sensitive_data('<WUNDERGROUND_API_KEY>') { Wunderground.key }
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

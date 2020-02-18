require 'vcr'
require 'webmock'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.ignore_localhost = true
  config.allow_http_connections_when_no_cassette = true
  config.configure_rspec_metadata!

  Rails.application.credentials.xmltime[:test].each_pair do |k,v|
    config.filter_sensitive_data("<#{k}>") { v }
  end
end
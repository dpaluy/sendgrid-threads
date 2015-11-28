require 'simplecov'
require 'sendgrid-threads'
require 'byebug'
require 'webmock/rspec'
require 'timecop'
require 'active_support/all'
require 'codeclimate-test-reporter'

if ENV["COVERAGE"]
  WebMock.disable_net_connect!(allow: "codeclimate.com")

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
  ]

  SimpleCov.start
  CodeClimate::TestReporter.start
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require "codeclimate-test-reporter"

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

end

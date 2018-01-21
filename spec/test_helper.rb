require 'rspec'
require 'json'
require 'factory_bot'
require 'faker'
require 'pry'
require 'dry/container/stub'
require 'rack/test'
require 'securerandom'

Dir['./spec/shared/**/*.rb'].sort.each { |f| require f }

require_relative '../system/boot'
Container.enable_stubs!
Container.finalize!

require_relative 'factories'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Rack::Test::Methods

  config.around(:example) do |ex|
    Container.resolve(:db).transaction(rollback: :always, auto_savepoint: true) { ex.run }
  end
end

def json_body(body = last_response.body)
  JSON.parse(body, symbolize_names: true)
end

def app
  Container.resolve(:web_application)
end

def expect_valid_headers
  expect(last_response.headers['Content-Type']).to eq 'application/json;charset=UTF-8'
  expect(last_response.headers['Cache-Control']).to eq 'no-store'
  expect(last_response.headers['Pragma']).to eq 'no-cache'
end

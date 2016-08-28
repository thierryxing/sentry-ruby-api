require 'rspec'
require 'webmock/rspec'

require File.expand_path('../../lib/sentry', __FILE__)

def capture_output
  out = StringIO.new
  $stdout = out
  $stderr = out
  yield
  $stdout = STDOUT
  $stderr = STDERR
  out.string
end

def load_fixture(name)
  File.new(File.dirname(__FILE__) + "/fixtures/#{name}.json")
end

RSpec.configure do |config|
  config.before(:all) do
    Sentry.endpoint = 'https://api.example.com/api/0'
    Sentry.auth_token = 'secret'
    Sentry.default_org_slug = 'sentry-sc'
  end
end

# GET
def stub_get(path, fixture, status_code=200)
  stub_request(:get, "#{Sentry.endpoint}#{path}").
      with(:headers => {'Authorization' => "Bearer #{Sentry.auth_token}", 'Content-Type' => 'application/json'}).
      to_return(body: load_fixture(fixture), status: status_code)
end

def a_get(path)
  a_request(:get, "#{Sentry.endpoint}#{path}").
      with(:headers => {'Authorization' => "Bearer #{Sentry.auth_token}", 'Content-Type' => 'application/json'})
end

# POST
def stub_post(path, fixture, status_code=200)
  stub_request(:post, "#{Sentry.endpoint}#{path}").
      with(:headers => {'Authorization' => "Bearer #{Sentry.auth_token}", 'Content-Type' => 'application/json'}).
      to_return(body: load_fixture(fixture), status: status_code)
end

def a_post(path)
  a_request(:post, "#{Sentry.endpoint}#{path}").
      with(:headers => {'Authorization' => "Bearer #{Sentry.auth_token}", 'Content-Type' => 'application/json'})
end

# PUT
def stub_put(path, fixture)
  stub_request(:put, "#{Sentry.endpoint}#{path}").
      with(:headers => {'Authorization' => "Bearer #{Sentry.auth_token}", 'Content-Type' => 'application/json'}).
      to_return(body: load_fixture(fixture))
end

def a_put(path)
  a_request(:put, "#{Sentry.endpoint}#{path}").
      with(:headers => {'Authorization' => "Bearer #{Sentry.auth_token}", 'Content-Type' => 'application/json'})
end

# DELETE
def stub_delete(path, fixture)
  stub_request(:delete, "#{Sentry.endpoint}#{path}").
      with(:headers => {'Authorization' => "Bearer #{Sentry.auth_token}", 'Content-Type' => 'application/json'}).
      to_return(body: load_fixture(fixture))
end

def a_delete(path)
  a_request(:delete, "#{Sentry.endpoint}#{path}").
      with(:headers => {'Authorization' => "Bearer #{Sentry.auth_token}", 'Content-Type' => 'application/json'})
end

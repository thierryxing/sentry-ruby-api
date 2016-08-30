require 'rspec'
require 'webmock/rspec'

require File.expand_path('../../lib/sentry-api', __FILE__)

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
    SentryApi.endpoint = 'https://api.example.com/api/0'
    SentryApi.auth_token = 'secret'
    SentryApi.default_org_slug = 'sentry-sc'
  end
end

# GET
def stub_get(path, fixture, status_code=200)
  stub_request(:get, "#{SentryApi.endpoint}#{path}").
      with(:headers => {'Authorization' => "Bearer #{SentryApi.auth_token}", 'Content-Type' => 'application/json'}).
      to_return(body: load_fixture(fixture), status: status_code)
end

def a_get(path)
  a_request(:get, "#{SentryApi.endpoint}#{path}").
      with(:headers => {'Authorization' => "Bearer #{SentryApi.auth_token}", 'Content-Type' => 'application/json'})
end

# POST
def stub_post(path, fixture, status_code=200)
  stub_request(:post, "#{SentryApi.endpoint}#{path}").
      with(:headers => {'Authorization' => "Bearer #{SentryApi.auth_token}", 'Content-Type' => 'application/json'}).
      to_return(body: load_fixture(fixture), status: status_code)
end

def a_post(path)
  a_request(:post, "#{SentryApi.endpoint}#{path}").
      with(:headers => {'Authorization' => "Bearer #{SentryApi.auth_token}", 'Content-Type' => 'application/json'})
end

# PUT
def stub_put(path, fixture)
  stub_request(:put, "#{SentryApi.endpoint}#{path}").
      with(:headers => {'Authorization' => "Bearer #{SentryApi.auth_token}", 'Content-Type' => 'application/json'}).
      to_return(body: load_fixture(fixture))
end

def a_put(path)
  a_request(:put, "#{SentryApi.endpoint}#{path}").
      with(:headers => {'Authorization' => "Bearer #{SentryApi.auth_token}", 'Content-Type' => 'application/json'})
end

# DELETE
def stub_delete(path, fixture)
  stub_request(:delete, "#{SentryApi.endpoint}#{path}").
      with(:headers => {'Authorization' => "Bearer #{SentryApi.auth_token}", 'Content-Type' => 'application/json'}).
      to_return(body: load_fixture(fixture))
end

def a_delete(path)
  a_request(:delete, "#{SentryApi.endpoint}#{path}").
      with(:headers => {'Authorization' => "Bearer #{SentryApi.auth_token}", 'Content-Type' => 'application/json'})
end

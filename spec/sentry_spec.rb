require 'spec_helper'

describe SentryApi do
  after { SentryApi.reset }

  describe ".client" do
    it "should be a SentryApi::Client" do
      expect(SentryApi.client).to be_a SentryApi::Client
    end

    it "should not override each other" do
      client1 = SentryApi.client(endpoint: 'https://api1.example.com', auth_token: '001')
      client2 = SentryApi.client(endpoint: 'https://api2.example.com', auth_token: '002')
      expect(client1.endpoint).to eq('https://api1.example.com')
      expect(client2.endpoint).to eq('https://api2.example.com')
      expect(client1.auth_token).to eq('001')
      expect(client2.auth_token).to eq('002')
    end

    it "should set auth_token to the auth_token when provided" do
      client = SentryApi.client(endpoint: 'https://api2.example.com', auth_token: '5b0c2c44939d4ea3b2f85a101d6495c8a085d2134eb542158235309606d0297e')
      expect(client.auth_token).to eq('5b0c2c44939d4ea3b2f85a101d6495c8a085d2134eb542158235309606d0297e')
    end
  end

  describe ".actions" do
    it "should return an array of client methods" do
      actions = SentryApi.actions
      expect(actions).to be_an Array
      expect(actions.first).to be_a Symbol
    end
  end

  describe ".endpoint=" do
    it "should set endpoint" do
      SentryApi.endpoint = 'https://api.example.com'
      expect(SentryApi.endpoint).to eq('https://api.example.com')
    end
  end

  describe ".org_slug=" do
    it "should set org_slug" do
      SentryApi.default_org_slug = 'sentry-sc'
      expect(SentryApi.default_org_slug).to eq('sentry-sc')
    end
  end

  describe ".auth_token=" do
    it "should set auth_token", focus: true do
      SentryApi.auth_token = '5b0c2c44939d4ea3b2f85a101d6495c8a085d2134eb542158235309606d0297e'
      expect(SentryApi.auth_token).to eq('5b0c2c44939d4ea3b2f85a101d6495c8a085d2134eb542158235309606d0297e')
    end
  end

  describe ".configure" do
    SentryApi::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set #{key}" do
        SentryApi.configure do |config|
          config.send("#{key}=", key)
          expect(SentryApi.send(key)).to eq(key)
        end
      end
    end
  end

  describe ".http_proxy" do
    it "delegates the method to Sentry::Request" do
      SentryApi.endpoint = 'https://api.example.com'
      request = class_spy(SentryApi::Request).as_stubbed_const

      SentryApi.http_proxy('fazbearentertainment.com', 1987, 'ffazbear', 'itsme')
      expect(request).to have_received(:http_proxy).
          with('fazbearentertainment.com', 1987, 'ffazbear', 'itsme')
    end
  end
end

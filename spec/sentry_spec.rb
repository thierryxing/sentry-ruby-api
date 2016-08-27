require 'spec_helper'

describe Sentry do
  after { Sentry.reset }

  describe ".client" do
    it "should be a Sentry::Client" do
      expect(Sentry.client).to be_a Sentry::Client
    end

    it "should not override each other" do
      client1 = Sentry.client(endpoint: 'https://api1.example.com', auth_token: '001')
      client2 = Sentry.client(endpoint: 'https://api2.example.com', auth_token: '002')
      expect(client1.endpoint).to eq('https://api1.example.com')
      expect(client2.endpoint).to eq('https://api2.example.com')
      expect(client1.auth_token).to eq('001')
      expect(client2.auth_token).to eq('002')
    end

    it "should set auth_token to the auth_token when provided" do
      client = Sentry.client(endpoint: 'https://api2.example.com', auth_token: '5b0c2c44939d4ea3b2f85a101d6495c8a085d2134eb542158235309606d0297e')
      expect(client.auth_token).to eq('5b0c2c44939d4ea3b2f85a101d6495c8a085d2134eb542158235309606d0297e')
    end
  end

  describe ".actions" do
    it "should return an array of client methods" do
      actions = Sentry.actions
      expect(actions).to be_an Array
      expect(actions.first).to be_a Symbol
    end
  end

  describe ".endpoint=" do
    it "should set endpoint" do
      Sentry.endpoint = 'https://api.example.com'
      expect(Sentry.endpoint).to eq('https://api.example.com')
    end
  end

  describe ".org_slug=" do
    it "should set org_slug" do
      Sentry.org_slug = 'sentry-sc'
      expect(Sentry.org_slug).to eq('sentry-sc')
    end
  end

  describe ".auth_token=" do
    it "should set auth_token", focus: true do
      Sentry.auth_token = '5b0c2c44939d4ea3b2f85a101d6495c8a085d2134eb542158235309606d0297e'
      expect(Sentry.auth_token).to eq('5b0c2c44939d4ea3b2f85a101d6495c8a085d2134eb542158235309606d0297e')
    end
  end

  describe ".configure" do
    Sentry::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set #{key}" do
        Sentry.configure do |config|
          config.send("#{key}=", key)
          expect(Sentry.send(key)).to eq(key)
        end
      end
    end
  end

  describe ".http_proxy" do
    it "delegates the method to Sentry::Request" do
      Sentry.endpoint = 'https://api.example.com'
      request = class_spy(Sentry::Request).as_stubbed_const

      Sentry.http_proxy('fazbearentertainment.com', 1987, 'ffazbear', 'itsme')
      expect(request).to have_received(:http_proxy).
          with('fazbearentertainment.com', 1987, 'ffazbear', 'itsme')
    end
  end
end

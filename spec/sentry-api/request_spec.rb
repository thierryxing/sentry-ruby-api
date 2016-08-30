require 'spec_helper'

describe SentryApi::Request do
  it { should respond_to :get }
  it { should respond_to :post }
  it { should respond_to :put }
  it { should respond_to :delete }
  before do
    @request = SentryApi::Request.new
  end

  describe ".default_options" do
    it "should have default values" do
      default_options = SentryApi::Request.default_options
      expect(default_options).to be_a Hash
      expect(default_options[:parser]).to be_a Proc
      expect(default_options[:format]).to eq(:json)
      expect(default_options[:headers]).to eq('Content-Type' => 'application/json')
      expect(default_options[:default_params]).to be_nil
    end
  end

  describe ".parse" do
    it "should return ObjectifiedHash" do
      body = JSON.unparse(a: 1, b: 2)
      expect(SentryApi::Request.parse(body)).to be_an SentryApi::ObjectifiedHash
      expect(SentryApi::Request.parse("true")).to be true
      expect(SentryApi::Request.parse("false")).to be false

      expect { SentryApi::Request.parse("string") }.to raise_error(SentryApi::Error::Parsing)
    end
  end

  describe "#set_request_defaults" do
    context "when endpoint is not set" do
      it "should raise Error::MissingCredentials" do
        @request.endpoint = nil
        expect do
          @request.set_request_defaults
        end.to raise_error(SentryApi::Error::MissingCredentials, 'Please set an endpoint to API')
      end
    end

    context "when endpoint is set" do
      before(:each) do
        @request.endpoint = 'http://rabbit-hole.example.org'
      end

      it "should set default_params" do
        @request.set_request_defaults
        expect(SentryApi::Request.default_params).to eq({})
      end
    end
  end

  describe "#set_authorization_header" do
    it "should set the correct header when setting an auth_token" do
      @request.auth_token = '3225e2804d31fea13fc41fc83bffef00cfaedc463118646b154acc6f94747603'
      expect(@request.send(:set_authorization_header, {})).to eq("Authorization" => "Bearer 3225e2804d31fea13fc41fc83bffef00cfaedc463118646b154acc6f94747603")
    end
  end
end

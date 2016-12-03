require 'spec_helper'

describe SentryApi::PaginatedResponse do
  before do
    array = [1, 2, 3, 4]
    @paginated_response = SentryApi::PaginatedResponse.new array
  end

  it "should respond to *_page and has_*_page methods" do
    expect(@paginated_response).to respond_to :next_page
    expect(@paginated_response).to respond_to :prev_page
    expect(@paginated_response).to respond_to :has_next_page?
    expect(@paginated_response).to respond_to :has_prev_page?
  end

  context '.parse_headers!' do
    it "should parse headers" do
      @paginated_response.parse_headers!('Link' => "<http://example.com/api/0/organizations/?&cursor=100:-1:1>; rel=\"previous\"; results=\"false\"; cursor=\"100:-1:1\", <http://example.com/api/0/organizations/?&cursor=100:1:0>; rel=\"next\"; results=\"true\"; cursor=\"100:1:0\"")
      client = @paginated_response.client = double('client')
      allow(client).to receive(:endpoint).and_return("http://example.com/api/0")
      expect(@paginated_response.has_next_page?).to be true
      expect(@paginated_response.has_prev_page?).to be false
    end
  end

  context '.each_page' do
    it "should iterate pages" do
      next_page = double('next_page')
      allow(@paginated_response).to receive(:has_next_page?).and_return(true)
      allow(@paginated_response).to receive(:next_page).and_return(next_page)
      allow(next_page).to receive(:has_next_page?).and_return(false)
      expect { |b| @paginated_response.each_page(&b) }.to yield_successive_args(@paginated_response, next_page)
    end
  end

  context '.auto_paginate' do
    it "should returns an array if block is not given" do
      next_page = double('next_page')
      allow(@paginated_response).to receive(:has_next_page?).and_return(true)
      allow(@paginated_response).to receive(:next_page).and_return(next_page)
      allow(next_page).to receive(:has_next_page?).and_return(false)
      allow(next_page).to receive(:to_ary).and_return([5, 6, 7, 8])
      expect(@paginated_response.auto_paginate).to contain_exactly(1, 2, 3, 4, 5, 6, 7, 8)
    end
  end
end

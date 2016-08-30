require 'spec_helper'

describe SentryApi::PageLinks do
  before do
    @page_links = SentryApi::PageLinks.new('Link' => "<http://example.com/api/0/organizations/?&cursor=100:-1:1>; rel=\"previous\"; results=\"false\"; cursor=\"100:-1:1\", <http://example.com/api/0/organizations/?&cursor=100:1:0>; rel=\"next\"; results=\"true\"; cursor=\"100:1:0\"")
  end

  context '.extract_links' do
    it 'should extract link header appropriately' do
      expect(@page_links.next).to eql 'http://example.com/api/0/organizations/?&cursor=100:1:0'
      expect(@page_links.previous).to be_nil
    end
  end
end

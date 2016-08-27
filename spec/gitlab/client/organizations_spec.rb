require 'spec_helper'

describe Sentry::Client do

  describe ".organizations" do
    before do
      stub_get("/organizations/?member=false", "organizations")
      @organizations = Sentry.organizations
    end

    it "should get the correct resource" do
      expect(a_get("/organizations/?member=false")).to have_been_made
    end

    it "should return a paginated response of organizations" do
      expect(@organizations).to be_a Sentry::PaginatedResponse
      expect(@organizations.first.name).to eq("The Interstellar Jurisdiction")
      expect(@organizations.first.slug).to eq("the-interstellar-jurisdiction")
    end
  end

end

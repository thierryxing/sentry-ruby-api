require 'spec_helper'

describe SentryApi::Client do

  describe ".team" do
    before do
      stub_get("/teams/org-slug/team-slug/", "team")
      @team = SentryApi.team("team-slug", "org-slug")
    end

    it "should get the correct resource" do
      expect(a_get("/teams/org-slug/team-slug/")).to have_been_made
    end

    it "should return an response of team" do
      expect(@team.slug).to eq("powerful-abolitionist")
    end
  end

end

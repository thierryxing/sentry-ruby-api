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

  describe ".organization_projects" do
    before do
      stub_get("/organizations/org-slug/projects/", "organization_projects")
      @projects = Sentry.organization_projects('org-slug')
    end

    it "should get the correct resource" do
      expect(a_get("/organizations/org-slug/projects/")).to have_been_made
    end

    it "should return a paginated response of organization's projects" do
      expect(@projects).to be_a Sentry::PaginatedResponse
      expect(@projects.first.status).to eq("active")
      expect(@projects.first.team.slug).to eq("powerful-abolitionist")
    end
  end

  describe ".organization" do
    before do
      stub_get("/organizations/org-slug/", "organization")
      @organization = Sentry.organization('org-slug')
    end

    it "should get the correct resource" do
      expect(a_get("/organizations/org-slug/")).to have_been_made
    end

    it "should return a response of organization" do
      expect(@organization).to be_a Sentry::ObjectifiedHash
      expect(@organization.slug).to eq("the-interstellar-jurisdiction")
      expect(@organization.teams.first["name"]).to eq("Ancient Gabelers")
    end
  end

  describe ".update_organization" do
    before do
      stub_put("/organizations/org-slug/", "update_organization")
      @edited_organization = Sentry.update_organization("org-slug", name: "Impeccably Designated")
    end

    it "should get the correct resource" do
      expect(a_put("/organizations/org-slug/")).to have_been_made
    end

    it "should return information about an update organization" do
      expect(@edited_organization.name).to eq("Impeccably Designated")
    end
  end

  describe ".organization_stats" do
    before do
      stub_get("/organizations/org-slug/stats/", "organization_stats").with(query: {stat: "received"})
      @stats = Sentry.organization_stats("org-slug", stat: "received")
    end

    it "should get the correct resource" do
      expect(a_get("/organizations/org-slug/stats/").with(query: {stat: "received"})).to have_been_made
    end

    it "should return array about an organization's event counts" do
      expect(@stats[0][0]).to eq(1472158800)
      expect(@stats[0][1]).to eq(6330)
    end
  end

end

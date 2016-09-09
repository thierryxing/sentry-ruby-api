require 'spec_helper'

describe SentryApi::Client do

  describe ".organizations" do
    before do
      stub_get("/organizations/?member=false", "organizations")
      @organizations = SentryApi.organizations
    end

    it "should get the correct resource" do
      expect(a_get("/organizations/?member=false")).to have_been_made
    end

    it "should return a paginated response of organizations" do
      expect(@organizations).to be_a SentryApi::PaginatedResponse
      expect(@organizations.first.name).to eq("The Interstellar Jurisdiction")
      expect(@organizations.first.slug).to eq("the-interstellar-jurisdiction")
    end
  end

  describe ".organization_projects" do
    before do
      stub_get("/organizations/sentry-sc/projects/", "organization_projects")
      @projects = SentryApi.organization_projects
    end

    it "should get the correct resource" do
      expect(a_get("/organizations/sentry-sc/projects/")).to have_been_made
    end

    it "should return a paginated response of organization's projects" do
      expect(@projects).to be_a SentryApi::PaginatedResponse
      expect(@projects.first.status).to eq("active")
      expect(@projects.first.team.slug).to eq("powerful-abolitionist")
    end
  end

  describe ".organization" do
    before do
      stub_get("/organizations/sentry-sc/", "organization")
      @organization = SentryApi.organization
    end

    it "should get the correct resource" do
      expect(a_get("/organizations/sentry-sc/")).to have_been_made
    end

    it "should return a response of organization" do
      expect(@organization).to be_a SentryApi::ObjectifiedHash
      expect(@organization.slug).to eq("the-interstellar-jurisdiction")
      expect(@organization.teams.first["name"]).to eq("Ancient Gabelers")
    end
  end

  describe ".update_organization" do
    before do
      stub_put("/organizations/sentry-sc/", "update_organization")
      @edited_organization = SentryApi.update_organization({name: "Impeccably Designated"})
    end

    it "should get the correct resource" do
      expect(a_put("/organizations/sentry-sc/")).to have_been_made
    end

    it "should return information about an update organization" do
      expect(@edited_organization.name).to eq("Impeccably Designated")
    end
  end

  describe ".organization_stats" do
    before do
      stub_get("/organizations/sentry-sc/stats/", "organization_stats").with(query: {stat: "received"})
      @stats = SentryApi.organization_stats({stat: "received"})
    end

    it "should get the correct resource" do
      expect(a_get("/organizations/sentry-sc/stats/").with(query: {stat: "received"})).to have_been_made
    end

    it "should return array about an organization's event counts" do
      expect(@stats[0][0]).to eq(1472158800)
      expect(@stats[0][1]).to eq(6330)
    end
  end

  describe ".create_team" do
    before do
      stub_post("/organizations/sentry-sc/teams/", "create_team").with(body: {name: "name"})
      @team = SentryApi.create_team({name: "name"})
    end

    it "should get the correct resource" do
      expect(a_post("/organizations/sentry-sc/teams/").with(body: {name: "name"})).to have_been_made
    end

    it "should return array about an organization's event counts" do
      expect(@team.slug).to eq("ancient-gabelers")
    end
  end

end

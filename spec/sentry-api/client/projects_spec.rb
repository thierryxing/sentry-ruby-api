require 'spec_helper'

describe SentryApi::Client do

  describe ".projects" do
    before do
      stub_get("/projects/", "projects")
      @projects = SentryApi.projects
    end

    it "should get the correct resource" do
      expect(a_get("/projects/")).to have_been_made
    end

    it "should return an array response of projects" do
      expect(@projects.first.slug).to eq("the-spoiled-yoghurt")
    end
  end

  describe ".project" do
    before do
      stub_get("/projects/sentry-sc/project-slug/", "project")
      @project=SentryApi.project("project-slug")
    end

    it "should get the correct resource" do
      expect(a_get("/projects/sentry-sc/project-slug/")).to have_been_made
    end

    it "should return a response of project" do
      expect(@project.name).to eq("Pump Station")
    end
  end

  describe ".update_project" do
    before do
      stub_put("/projects/sentry-sc/project-slug/", "update_project")
      @project=SentryApi.update_project("project-slug", {name: "Plane Proxy", slug: "plane-proxy", isBookmarked: true, options: {}})
    end

    it "should get the correct resource" do
      expect(a_put("/projects/sentry-sc/project-slug/")).to have_been_made
    end

    it "should return a response of project" do
      expect(@project.name).to eq("Plane Proxy")
    end
  end

  describe ".delete_project" do
    before do
      stub_delete("/projects/sentry-sc/project-slug/", "delete_project")
      SentryApi.delete_project("project-slug")
    end

    it "should get the correct resource" do
      expect(a_delete("/projects/sentry-sc/project-slug/")).to have_been_made
    end
  end

  describe ".project_stats" do
    before do
      stub_get("/projects/sentry-sc/project-slug/stats/", "project_stats").with(query: {stat: "received"})
      @stats = SentryApi.project_stats("project-slug", {stat: "received"})
    end

    it "should get the correct resource" do
      expect(a_get("/projects/sentry-sc/project-slug/stats/").with(query: {stat: "received"})).to have_been_made
    end

    it "should return array about an project's event counts" do
      expect(@stats[0][0]).to eq(1472158800)
      expect(@stats[0][1]).to eq(1012)
    end
  end

  describe ".project_dsym_files" do
    before do
      stub_get("/projects/sentry-sc/project-slug/files/dsyms/", "project_dsym_files")
      @files = SentryApi.project_dsym_files("project-slug")
    end

    it "should get the correct resource" do
      expect(a_get("/projects/sentry-sc/project-slug/files/dsyms/")).to have_been_made
    end

    it "should return a response of result" do
      expect(@files.first.objectName).to eq("GMThirdParty")
    end
  end

  describe ".create_client_key" do
    before do
      stub_post("/projects/sentry-sc/project-slug/keys/", "create_client_key")
      @result = SentryApi.create_client_key("project-slug", "Fabulous Key")
    end

    it "should get the correct resource" do
      expect(a_post("/projects/sentry-sc/project-slug/keys/")).to have_been_made
    end

    it "should return a response of result" do
      expect(@result.label).to eq("Fabulous Key")
    end
  end

  describe ".delete_client_key" do
    before do
      stub_delete("/projects/sentry-sc/project-slug/keys/87c990582e07446b9907b357fc27730e/", "delete_client_key")
      SentryApi.delete_client_key("project-slug", "87c990582e07446b9907b357fc27730e")
    end

    it "should get the correct resource" do
      expect(a_delete("/projects/sentry-sc/project-slug/keys/87c990582e07446b9907b357fc27730e/")).to have_been_made
    end
  end

  describe ".client_keys" do
    before do
      stub_get("/projects/sentry-sc/project-slug/keys/", "client_keys")
      @keys = SentryApi.client_keys("project-slug")
    end

    it "should get the correct resource" do
      expect(a_get("/projects/sentry-sc/project-slug/keys/")).to have_been_made
    end

    it "should return a response of result" do
      expect(@keys.first.label).to eq("Fabulous Key")
    end
  end

  describe ".update_client_key" do
    before do
      stub_put("/projects/sentry-sc/project-slug/keys/b692781e8be347b98722d62506fc8aa8/", "update_client_key")
      @key = SentryApi.update_client_key("project-slug", "b692781e8be347b98722d62506fc8aa8", {name: "Quite Positive Key"})
    end

    it "should get the correct resource" do
      expect(a_put("/projects/sentry-sc/project-slug/keys/b692781e8be347b98722d62506fc8aa8/")).to have_been_made
    end

    it "should return a response of result" do
      expect(@key.label).to eq("Quite Positive Key")
    end
  end

  describe ".project_events" do
    before do
      stub_get("/projects/sentry-sc/project-slug/events/", "project_events")
      @event = SentryApi.project_events("project-slug")
    end

    it "should get the correct resource" do
      expect(a_get("/projects/sentry-sc/project-slug/events/")).to have_been_made
    end

    it "should return an array response of events" do
      expect(@event.first.eventID).to eq("ef4e4e732d2544279851cf7c1b42716e")
    end
  end

  describe ".project_event" do
    before do
      stub_get("/projects/sentry-sc/project-slug/events/ef4e4e732d2544279851cf7c1b42716e/", "project_event")
      @event = SentryApi.project_event("project-slug", "ef4e4e732d2544279851cf7c1b42716e")
    end

    it "should get the correct resource" do
      expect(a_get("/projects/sentry-sc/project-slug/events/ef4e4e732d2544279851cf7c1b42716e/")).to have_been_made
    end

    it "should return a response of event" do
      expect(@event.eventID).to eq("ef4e4e732d2544279851cf7c1b42716e")
    end
  end

  describe ".project_issues" do
    before do
      stub_get("/projects/sentry-sc/project-slug/issues/", "project_issues")
      @issues = SentryApi.project_issues("project-slug")
    end

    it "should get the correct resource" do
      expect(a_get("/projects/sentry-sc/project-slug/issues/")).to have_been_made
    end

    it "should return a array of issues" do
      expect(@issues.first.culprit).to eq("org.hsqldb.jdbc.Util in throwError")
    end
  end

end

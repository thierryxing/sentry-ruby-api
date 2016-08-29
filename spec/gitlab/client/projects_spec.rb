require 'spec_helper'

describe Sentry::Client do

  describe ".projects" do
    before do
      stub_get("/projects/", "projects")
      @projects = Sentry.projects
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
      stub_get("/projects/org-slug/project-slug/", "project")
      @project=Sentry.project("project-slug", "org-slug")
    end

    it "should get the correct resource" do
      expect(a_get("/projects/org-slug/project-slug/")).to have_been_made
    end

    it "should return a response of project" do
      expect(@project.name).to eq("Pump Station")
    end
  end

  describe ".update_project" do
    before do
      stub_put("/projects/org-slug/project-slug/", "update_project")
      @project=Sentry.update_project("project-slug", {name: "Plane Proxy", slug: "plane-proxy", isBookmarked: true, options: {}}, "org-slug")
    end

    it "should get the correct resource" do
      expect(a_put("/projects/org-slug/project-slug/")).to have_been_made
    end

    it "should return a response of project" do
      expect(@project.name).to eq("Plane Proxy")
    end
  end

  describe ".delete_project" do
    before do
      stub_delete("/projects/org-slug/project-slug/", "delete_project")
      Sentry.delete_project("project-slug", "org-slug")
    end

    it "should get the correct resource" do
      expect(a_delete("/projects/org-slug/project-slug/")).to have_been_made
    end
  end

  describe ".project_stats" do
    before do
      stub_get("/projects/org-slug/project-slug/stats/", "project_stats").with(query: {stat: "received"})
      @stats = Sentry.project_stats("project-slug", {stat: "received"}, "org-slug")
    end

    it "should get the correct resource" do
      expect(a_get("/projects/org-slug/project-slug/stats/").with(query: {stat: "received"})).to have_been_made
    end

    it "should return array about an project's event counts" do
      expect(@stats[0][0]).to eq(1472158800)
      expect(@stats[0][1]).to eq(1012)
    end
  end

  describe ".project_dsym_files" do
    before do
      stub_get("/projects/org-slug/project-slug/files/dsyms/", "project_dsym_files")
      @files = Sentry.project_dsym_files("project-slug", "org-slug")
    end

    it "should get the correct resource" do
      expect(a_get("/projects/org-slug/project-slug/files/dsyms/")).to have_been_made
    end

    it "should return a response of result" do
      expect(@files.first.objectName).to eq("GMThirdParty")
    end
  end

  describe ".create_client_key" do
    before do
      stub_post("/projects/org-slug/project-slug/keys/", "create_client_key")
      @result = Sentry.create_client_key("project-slug", "Fabulous Key", "org-slug")
    end

    it "should get the correct resource" do
      expect(a_post("/projects/org-slug/project-slug/keys/")).to have_been_made
    end

    it "should return a response of result" do
      expect(@result.label).to eq("Fabulous Key")
    end
  end

  describe ".delete_client_key" do
    before do
      stub_delete("/projects/org-slug/project-slug/keys/87c990582e07446b9907b357fc27730e/", "delete_client_key")
      Sentry.delete_client_key("project-slug", "87c990582e07446b9907b357fc27730e", "org-slug")
    end

    it "should get the correct resource" do
      expect(a_delete("/projects/org-slug/project-slug/keys/87c990582e07446b9907b357fc27730e/")).to have_been_made
    end
  end

  describe ".client_keys" do
    before do
      stub_get("/projects/org-slug/project-slug/keys/", "client_keys")
      @keys = Sentry.client_keys("project-slug", "org-slug")
    end

    it "should get the correct resource" do
      expect(a_get("/projects/org-slug/project-slug/keys/")).to have_been_made
    end

    it "should return a response of result" do
      expect(@keys.first.label).to eq("Fabulous Key")
    end
  end

  describe ".update_client_key" do
    before do
      stub_put("/projects/org-slug/project-slug/keys/b692781e8be347b98722d62506fc8aa8/", "update_client_key")
      @key = Sentry.update_client_key("project-slug", "b692781e8be347b98722d62506fc8aa8", {name: "Quite Positive Key"}, "org-slug")
    end

    it "should get the correct resource" do
      expect(a_put("/projects/org-slug/project-slug/keys/b692781e8be347b98722d62506fc8aa8/")).to have_been_made
    end

    it "should return a response of result" do
      expect(@key.label).to eq("Quite Positive Key")
    end
  end


end

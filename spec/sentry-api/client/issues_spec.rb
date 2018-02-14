require 'spec_helper'

describe SentryApi::Client do

  describe ".issues" do
    before do
      stub_get("/projects/sentry-sc/project-slug/issues/", "project_issues")
      @issues = SentryApi.issues("project-slug")
    end

    it "should get the correct resource" do
      expect(a_get("/projects/sentry-sc/project-slug/issues/")).to have_been_made
    end

    it "should return a array of issues" do
      expect(@issues.first.culprit).to eq("org.hsqldb.jdbc.Util in throwError")
    end
  end

end

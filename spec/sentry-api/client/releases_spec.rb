require 'spec_helper'

describe SentryApi::Client do

  describe ".release" do
    before do
      stub_get("/projects/sentry-sc/project-slug/releases/1.0/", "release")
      @release = SentryApi.release("project-slug", "1.0")
    end

    it "should get the correct resource" do
      expect(a_get("/projects/sentry-sc/project-slug/releases/1.0/")).to have_been_made
    end

    it "should return a response of release" do
      expect(@release.version).to eq("6945297bf064ca1ce68cfba53fbb91e2ef47eec6")
    end
  end

end

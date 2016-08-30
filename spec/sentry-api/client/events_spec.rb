require 'spec_helper'

describe SentryApi::Client do

  describe ".issue" do
    before do
      stub_get("/issues/1/", "issue")
      @issue = SentryApi.issue("1")
    end

    it "should get the correct resource" do
      expect(a_get("/issues/1/")).to have_been_made
    end

    it "should return a response of issue" do
      expect(@issue.title).to eq("This is an example python exception")
    end
  end

  describe ".issue_events" do
    before do
      stub_get("/issues/1/events/", "issue_events")
      @events = SentryApi.issue_events("1")
    end

    it "should get the correct resource" do
      expect(a_get("/issues/1/events/")).to have_been_made
    end

    it "should return an array response of events" do
      expect(@events.first.eventID).to eq("03fc4d526a3d47c7b2219ca1f3c81cf7")
    end
  end

  describe ".issue_hashes" do
    before do
      stub_get("/issues/1/hashes/", "issue_hashes")
      @hashes = SentryApi.issue_hashes("1")
    end

    it "should get the correct resource" do
      expect(a_get("/issues/1/hashes/")).to have_been_made
    end

    it "should return an array response of hashes" do
      expect(@hashes.first.id).to eq("c4a4d06bc314205bb3b6bdb612dde7f1")
    end
  end

  describe ".remove_issue" do
    before do
      stub_delete("/issues/1/", "remove_issue")
      @hashes = SentryApi.remove_issue("1")
    end

    it "should get the correct resource" do
      expect(a_delete("/issues/1/")).to have_been_made
    end
  end

  describe ".remove_issue" do
    before do
      stub_delete("/issues/1/", "remove_issue")
      @hashes = SentryApi.remove_issue("1")
    end

    it "should get the correct resource" do
      expect(a_delete("/issues/1/")).to have_been_made
    end
  end

  describe ".update_issue" do
    before do
      stub_put("/issues/1/", "update_issue")
      @issue=SentryApi.update_issue("1", {status: "resolved", assignedTo: "thierry.xing@gmail.com", hasSeen: true, isBookmarked: true, isSubscribed: true})
    end

    it "should get the correct resource" do
      expect(a_put("/issues/1/")).to have_been_made
    end

    it "should return a response of issue" do
      expect(@issue.culprit).to eq("lib/tasks/device_task.rake in rescue in do_send_data at line 140")
    end
  end

  describe ".latest_event" do
    before do
      stub_get("/issues/1/events/latest/", "latest_event")
      @event = SentryApi.latest_event("1")
    end

    it "should get the correct resource" do
      expect(a_get("/issues/1/events/latest/")).to have_been_made
    end

    it "should return a response of event" do
      expect(@event.eventID).to eq("03fc4d526a3d47c7b2219ca1f3c81cf7")
    end
  end

  describe ".oldest_event" do
    before do
      stub_get("/issues/1/events/oldest/", "oldest_event")
      @event = SentryApi.oldest_event("1")
    end

    it "should get the correct resource" do
      expect(a_get("/issues/1/events/oldest/")).to have_been_made
    end

    it "should return a response of event" do
      expect(@event.eventID).to eq("03fc4d526a3d47c7b2219ca1f3c81cf7")
    end
  end

end

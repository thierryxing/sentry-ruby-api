class SentryApi::Client

  module Events

    # Retrieve an Issue
    #
    # @example
    #   SentryApi.issue('120732258')
    #
    # @param issue_id [String] the ID of the issue to retrieve.
    # @return [SentryApi::ObjectifiedHash]
    def issue(issue_id)
      get("/issues/#{issue_id}/")
    end

    # List an Issue’s Events
    #
    # @example
    #   SentryApi.issue_events('120732258')
    #
    # @param issue_id [String] the ID of the issue to retrieve.
    # @return [Array<SentryApi::ObjectifiedHash>]
    def issue_events(issue_id)
      get("/issues/#{issue_id}/events/")
    end

    # List an Issue’s Hashes
    #
    # @example
    #   SentryApi.issues_hashes('120732258')
    #
    # @param issue_id [String] the ID of the issue to retrieve.
    # @return [Array<SentryApi::ObjectifiedHash>]
    def issue_hashes(issue_id)
      get("/issues/#{issue_id}/hashes/")
    end

    # Removes an individual issue.
    #
    # @example
    #   SentryApi.remove_issue('120732258')
    #
    # @param issue_id [String] the ID of the issue to retrieve.
    def remove_issue(issue_id)
      delete("/issues/#{issue_id}/")
    end

    # Update an individual issue.
    #
    # @example
    #   SentryApi.update_issue('120732258')
    #   SentryApi.update_issue('120732258',{status:'resolved'})
    #   SentryApi.update_issue('120732258',{status:'resolved', assignedTo:'thierry.xing@gmail.com'})
    #
    # @param issue_id [String] the ID of the issue to retrieve.
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :status the new status for the groups. Valid values are "resolved", "unresolved" and "muted".
    # @option options [String] :assignedTo the username of the user that should be assigned to this issue.
    # @option options [Boolean] :hasSeen in case this API call is invoked with a user context this allows changing of the flag that indicates if the user has seen the event.
    # @option options [Boolean] :isBookmarked in case this API call is invoked with a user context this allows changing of the bookmark flag.
    # @option options [Boolean] :isSubscribed in case this API call is invoked with a user context this allows changing of the subscribed flag.
    # @return <SentryApi::ObjectifiedHash>
    def update_issue(issue_id, options={})
      put("/issues/#{issue_id}/", body: options)
    end

    # Retrieves the details of the latest event.
    #
    # @example
    #   SentryApi.latest_event('120633628')
    #
    # @param issue_id [String] the ID of the issue to retrieve.
    # @return [SentryApi::ObjectifiedHash]
    def latest_event(issue_id)
      get("/issues/#{issue_id}/events/latest/")
    end

    # Retrieves the details of the oldest event.
    #
    # @example
    #   SentryApi.oldest_event('120633628')
    #
    # @param issue_id [String] the ID of the issue to retrieve.
    # @return [SentryApi::ObjectifiedHash]
    def oldest_event(issue_id)
      get("/issues/#{issue_id}/events/oldest/")
    end

  end

end

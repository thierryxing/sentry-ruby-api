class Sentry::Client

  module Events

    # Retrieve an Issue
    #
    # @example
    #   Sentry.issue('120732258')
    #
    # @param issue_id [String] the ID of the issue to retrieve.
    # @return Sentry::ObjectifiedHash
    def issue(issue_id)
      get("/issues/#{issue_id}/")
    end

    # List an Issue’s Events
    #
    # @example
    #   Sentry.issue_events('120732258')
    #
    # @param issue_id [String] the ID of the issue to retrieve.
    # @return [Array<Sentry::ObjectifiedHash>]
    def issue_events(issue_id)
      get("/issues/#{issue_id}/events/")
    end

    # List an Issue’s Hashes
    #
    # @example
    #   Sentry.issues_hashes('120732258')
    #
    # @param issue_id [String] the ID of the issue to retrieve.
    # @return [Array<Sentry::ObjectifiedHash>]
    def issue_hashes(issue_id)
      get("/issues/#{issue_id}/hashes/")
    end

    # Removes an individual issue.
    #
    # @example
    #   Sentry.remove_issue('120732258')
    #
    # @param issue_id [String] the ID of the issue to retrieve.
    def remove_issue(issue_id)
      delete("/issues/#{issue_id}/")
    end

    # Update an individual issue.
    #
    # @example
    #   Sentry.update_issue('120732258')
    #   Sentry.update_issue('120732258',{status:'resolved'})
    #   Sentry.update_issue('120732258',{status:'resolved', assignedTo:'thierry.xing@gmail.com'})
    #
    # @param issue_id [String] the ID of the issue to retrieve.
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :status the new status for the groups. Valid values are "resolved", "unresolved" and "muted".
    # @option options [String] :assignedTo the username of the user that should be assigned to this issue.
    # @option options [Boolean] :hasSeen in case this API call is invoked with a user context this allows changing of the flag that indicates if the user has seen the event.
    # @option options [Boolean] :isBookmarked in case this API call is invoked with a user context this allows changing of the bookmark flag.
    # @option options [Boolean] :isSubscribed in case this API call is invoked with a user context this allows changing of the subscribed flag.
    def update_issue(issue_id, options={})
      put("/issues/#{issue_id}/", body: options)
    end

    # Retrieves the details of the latest event.
    #
    # @example
    #   Sentry.latest_event('120633628')
    #
    # @param issue_id [String] the ID of the issue to retrieve.
    # @return Sentry::ObjectifiedHash
    def latest_event(issue_id)
      get("/issues/#{issue_id}/events/latest/")
    end

    # Retrieves the details of the oldest event.
    #
    # @example
    #   Sentry.oldest_event('120633628')
    #
    # @param issue_id [String] the ID of the issue to retrieve.
    # @return Sentry::ObjectifiedHash
    def oldest_event(issue_id)
      get("/issues/#{issue_id}/events/oldest/")
    end

  end

end

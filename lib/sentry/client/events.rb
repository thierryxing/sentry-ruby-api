class Sentry::Client

  module Events

    # Return details on an individual issue.
    def issue
    end

    # Return a list of aggregates bound to a project
    #
    # @example
    #   Sentry.projects
    #
    # @return [Array<Sentry::ObjectifiedHash>]
    def issues
    end

    # This endpoint lists an issue’s events.
    def issues_events

    end

    # This endpoint lists an issue’s hashes, which are the generated checksums used to aggregate individual events.
    def issues_hashes

    end

    # Removes an individual issue.
    def remove_issue

    end

    # Return a list of sampled events bound to a project.
    #
    # @example
    #   Sentry.projects
    #
    # @return [Array<Sentry::ObjectifiedHash>]
    def events
    end

    # Retrieves the details of the latest sample for an aggregate.
    #
    # @example
    #   Sentry.projects
    #
    # @return [Array<Sentry::ObjectifiedHash>]
    def latest_events
    end

    # Retrieves the details of the oldest sample for an aggregate.
    #
    # @example
    #   Sentry.projects
    #
    # @return [Array<Sentry::ObjectifiedHash>]
    def oldest_events
    end

  end

end

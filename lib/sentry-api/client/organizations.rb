class SentryApi::Client

  module Organizations
    # List your Organizations.
    #
    # @example
    #   SentryApi.organizations
    #
    # @param member [Boolean] Restrict results to organizations which you have membership
    # @return [Array<SentryApi::ObjectifiedHash>]
    def organizations(member=false)
      get("/organizations/", query: {member: member})
    end

    # List an Organization’s Projects
    #
    # @example
    #   SentryApi.organization_projects
    #   SentryApi.organization_projects('slug')
    #
    # @return [Array<SentryApi::ObjectifiedHash>]
    def organization_projects
      get("/organizations/#{@default_org_slug}/projects/")
    end

    # Retrieve an Organization
    #
    # @example
    #   SentryApi.organization
    #   SentryApi.organization('slug')
    #
    # @return [SentryApi::ObjectifiedHash]
    def organization
      get("/organizations/#{@default_org_slug}/")
    end

    # Update an Organization
    #
    # @example
    #   SentryApi.update_organization('slug')
    #   SentryApi.update_organization('slug',{name:'new-name'})
    #   SentryApi.update_organization('slug',{name:'new-name', slug:'new-slug'})
    #
    # @param [Hash] options A customizable set of options.
    # @option options [String] :name an optional new name for the organization.
    # @option options [String] :slug an optional new slug for the organization. Needs to be available and unique.
    # @return [SentryApi::ObjectifiedHash]
    def update_organization(options={})
      put("/organizations/#{@default_org_slug}/", body: options)
    end

    # Retrieve Event Counts for an Organization
    #
    # @example
    #   SentryApi.organization_stats('slug')
    #   SentryApi.organization_stats('slug', {stat:'received', since:'1472158800'})
    #
    # @param [Hash] options A customizable set of options.
    # @option options [String] :stat the name of the stat to query ("received", "rejected", "blacklisted")
    # @option options [Timestamp] :since a timestamp to set the start of the query in seconds since UNIX epoch.
    # @option options [Timestamp] :until a timestamp to set the end of the query in seconds since UNIX epoch.
    # @option options [String] :resolution an explicit resolution to search for (eg: 10s). This should not be used unless you are familiar with Sentry’s internals as it’s restricted to pre-defined values.
    # @return [Array<Array>]
    def organization_stats(options={})
      get("/organizations/#{@default_org_slug}/stats/", query: options)
    end

    # Create a new team bound to an organization
    #
    # @example
    #   SentryApi.create_project('team-slug', {name:'team-name', slug:'team-slug'})
    #
    # @param [Hash] options A customizable set of options.
    # @option options [String] :name the name for the new team.
    # @option options [String] :slug optionally a slug for the new team. If it’s not provided a slug is generated from the name.
    # @return [SentryApi::ObjectifiedHash]
    def create_team(options={})
      post("/organizations/#{@default_org_slug}/teams/", body: options)
    end

    # Return a list of teams bound to a organization.
    #
    # @example
    #   SentryApi.organization_teams('team-slug')
    #
    # @return [Array<SentryApi::ObjectifiedHash>]
    def organization_teams
      get("/organizations/#{@default_org_slug}/teams/")
    end

  end

end
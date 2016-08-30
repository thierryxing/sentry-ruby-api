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
    # @param organization_slug [String] the slug of the organization for which the projects should be listed.
    # @return [Array<SentryApi::ObjectifiedHash>]
    def organization_projects(organization_slug="")
      organization_slug = @default_org_slug if organization_slug == ""
      get("/organizations/#{organization_slug}/projects/")
    end

    # Retrieve an Organization
    #
    # @example
    #   SentryApi.organization
    #   SentryApi.organization('slug')
    #
    # @param organization_slug [String] the slug of the organization the team should be created for.
    # @return [SentryApi::ObjectifiedHash]
    def organization(organization_slug="")
      organization_slug = @default_org_slug if organization_slug == ""
      get("/organizations/#{organization_slug}/")
    end

    # Update an Organization
    #
    # @example
    #   SentryApi.update_organization('slug')
    #   SentryApi.update_organization('slug',{name:'new-name'})
    #   SentryApi.update_organization('slug',{name:'new-name', slug:'new-slug'})
    #
    # @param organization_slug [String] the slug of the organization the team should be created for.
    # @param [Hash] options A customizable set of options.
    # @option options [String] :name an optional new name for the organization.
    # @option options [String] :slug an optional new slug for the organization. Needs to be available and unique.
    # @return [SentryApi::ObjectifiedHash]
    def update_organization(organization_slug, options={})
      put("/organizations/#{organization_slug}/", body: options)
    end

    # Retrieve Event Counts for an Organization
    #
    # @example
    #   SentryApi.organization_stats('slug')
    #   SentryApi.organization_stats('slug', {stat:'received', since:'1472158800'})
    #
    # @param organization_slug [String] the slug of the organization for which the stats should be retrieved.
    # @param [Hash] options A customizable set of options.
    # @option options [String] :stat the name of the stat to query ("received", "rejected", "blacklisted")
    # @option options [Timestamp] :since a timestamp to set the start of the query in seconds since UNIX epoch.
    # @option options [Timestamp] :until a timestamp to set the end of the query in seconds since UNIX epoch.
    # @option options [String] :resolution an explicit resolution to search for (eg: 10s). This should not be used unless you are familiar with Sentry’s internals as it’s restricted to pre-defined values.
    # @return [Array<Array>]
    def organization_stats(organization_slug, options={})
      get("/organizations/#{organization_slug}/stats/", query: options)
    end

  end

end
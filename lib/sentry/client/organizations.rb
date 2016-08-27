class Sentry::Client

  module Organizations
    # List your Organizations.
    #
    # @example
    #   Sentry.organizations
    #
    # @param  [Hash] options A customizable set of options.
    # @option member [bool] Restrict results to organizations which you have membership
    # @return [Array<Sentry::ObjectifiedHash>]
    def organizations(member=false)
      get("/organizations/", query: {member: member})
    end

    # List an Organization’s Projects
    #
    # @example
    #   Sentry.organization_projects('slug')
    #
    # @param  [Hash] options A customizable set of options.
    # @option organization_slug [string] the slug of the organization for which the projects should be listed.
    # @return [Array<Sentry::ObjectifiedHash>]
    def organization_projects(organization_slug)
      get("/organizations/#{organization_slug}/projects/")
    end

  end

end
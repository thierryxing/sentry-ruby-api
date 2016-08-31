class SentryApi::Client

  module Teams

    # Create a new project bound to a team.
    #
    # @example
    #   SentryApi.create_project('team-slug',{name:'new-name'})
    #
    # @param team_slug [String] the slug of the team to create a new project for.
    # @param organization_slug [String]  the slug of the organization the team belongs to.
    # @param [Hash] options A customizable set of options.
    # @option options [String] :name the name for the new project.
    # @option options [String] :slug optionally a slug for the new project. If it’s not provided a slug is generated from the name.
    # @return [SentryApi::ObjectifiedHash]
    def create_project(team_slug, options={}, organization_slug="")
      organization_slug = @default_org_slug if organization_slug == ""
      post("/teams/#{organization_slug}/#{team_slug}/projects/", body: options)
    end


  end

end

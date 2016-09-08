class SentryApi::Client

  module Teams

    # Create a new project bound to a team.
    #
    # @example
    #   SentryApi.create_project('team-slug', {name:'team-name'})
    #
    # @param team_slug [String] the slug of the team
    # @param [Hash] options A customizable set of options.
    # @option options [String] :name the name for the new project.
    # @option options [String] :slug optionally a slug for the new project. If it’s not provided a slug is generated from the name.
    # @return [SentryApi::ObjectifiedHash]
    def create_project(team_slug, options={})
      post("/teams/#{@default_org_slug}/#{team_slug}/projects/", body: options)
    end

    # Schedules a team for deletion
    #
    # @example
    #   SentryApi.delete_team('team-slug')
    #
    # @param team_slug [String] the slug of the team
    def delete_team(team_slug)
      delete("/teams/#{@default_org_slug}/#{team_slug}/")
    end

    # Return a list of projects bound to a team
    #
    # @example
    #   SentryApi.delete_team('team-slug')
    #
    # @param team_slug [String] the slug of the team
    # @return [Array<SentryApi::ObjectifiedHash>]
    def team_projects(team_slug)
      get("/teams/#{@default_org_slug}/#{team_slug}/projects/")
    end

    # Return details on an individual team.
    #
    # @example
    #   SentryApi.team_projects('team-slug')
    #
    # @param team_slug [String] the slug of the team
    # @return [SentryApi::ObjectifiedHash]
    def team(team_slug)
      get("/teams/#{@default_org_slug}/#{team_slug}/")
    end

    # Update various attributes and configurable settings for the given team.
    #
    # @example
    #   SentryApi.update_team('team-slug', {name:'team-name'})
    #
    # @param team_slug [String] the slug of the team
    # @param [Hash] options A customizable set of options.
    # @option options [String] :name the name for the new project.
    # @option options [String] :slug optionally a slug for the new project. If it’s not provided a slug is generated from the name.
    # @return [SentryApi::ObjectifiedHash]
    def update_team(team_slug, options={})
      get("/teams/#{@default_org_slug}/#{team_slug}/", body: options)
    end

  end
end

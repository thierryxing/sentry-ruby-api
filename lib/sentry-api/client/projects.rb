class SentryApi::Client

  module Projects
    # List your Projects
    #
    # @example
    #   SentryApi.projects
    #
    # @return [Array<SentryApi::ObjectifiedHash>]
    def projects
      get("/projects/")
    end

    # Retrieve a Project
    #
    # @example
    #   SentryApi.project('project-slug')
    #
    # @param project_slug [String] the slug of the project to retrieve.
    # @param organization_slug [String] the slug of the organization the project belong to.
    # @return [SentryApi::ObjectifiedHash]
    def project(project_slug, organization_slug="")
      organization_slug = @default_org_slug if organization_slug == ""
      get("/projects/#{organization_slug}/#{project_slug}/")
    end

    # Update a Project
    #
    # @example
    #   SentryApi.update_project('project-slug', {name:'new-name', slug:'new-slug', is_bookmarked:false})
    #
    # @param project_slug [String] the slug of the project to retrieve.
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :name the new name for the project.
    # @option options [String] :slug the new slug for the project.
    # @option options [String] :isBookmarked in case this API call is invoked with a user context this allows changing of the bookmark flag.
    # @option options [Hash] optional options to override in the project settings.
    # @param organization_slug [String] the slug of the organization the project belong to.
    # @return [SentryApi::ObjectifiedHash]
    def update_project(project_slug, options={}, organization_slug="")
      organization_slug = @default_org_slug if organization_slug == ""
      put("/projects/#{organization_slug}/#{project_slug}/", body: options)
    end

    # Delete a Project.
    #
    # @example
    #   SentryApi.delete_project('project-slug')
    #
    # @param project_slug [String] the slug of the project to delete.
    # @param organization_slug [String] the slug of the organization the project belong to.
    def delete_project(project_slug, organization_slug="")
      organization_slug = @default_org_slug if organization_slug == ""
      delete("/projects/#{organization_slug}/#{project_slug}/")
    end

    # Retrieve Event Counts for an Project
    #
    # @example
    #   SentryApi.project_stats('slug')
    #   SentryApi.project_stats('slug', {stat:'received', since:'1472158800'})
    #
    # @param project_slug [String] the slug of the project.
    # @param [Hash] options A customizable set of options.
    # @option options [String] :stat the name of the stat to query ("received", "rejected", "blacklisted")
    # @option options [Timestamp] :since a timestamp to set the start of the query in seconds since UNIX epoch.
    # @option options [Timestamp] :until a timestamp to set the end of the query in seconds since UNIX epoch.
    # @option options [String] :resolution an explicit resolution to search for (eg: 10s). This should not be used unless you are familiar with Sentry’s internals as it’s restricted to pre-defined values.
    # @param organization_slug [String] the slug of the organization the project belong to.
    # @return [Array<Array>]
    def project_stats(project_slug, options={}, organization_slug="")
      get("/projects/#{organization_slug}/#{project_slug}/stats/", query: options)
    end

    # List a Project’s DSym Files.
    #
    # @example
    #   SentryApi.project_dsym_files('project-slug')
    #
    # @param organization_slug [String] the slug of the organization.
    # @param project_slug [String] the slug of the project to list the dsym files of.
    # @return [Array<SentryApi::ObjectifiedHash>]
    def project_dsym_files(project_slug, organization_slug="")
      organization_slug = @default_org_slug if organization_slug == ""
      get("/projects/#{organization_slug}/#{project_slug}/files/dsyms/")
    end

    # List a Project’s Client Keys.
    #
    # @example
    #   SentryApi.client_keys('project-slug')
    #
    # @param project_slug [String] the slug of the project the client keys belong to.
    # @param organization_slug [String] the slug of the organization the client keys belong to.
    # @return [Array<SentryApi::ObjectifiedHash>]
    def client_keys(project_slug, organization_slug="")
      organization_slug = @default_org_slug if organization_slug == ""
      get("/projects/#{organization_slug}/#{project_slug}/keys/")
    end

    # Create a new Client Key.
    #
    # @example
    #   SentryApi.create_client_key('project-slug','new-name')
    #
    # @param project_slug [String] the slug of the project the client keys belong to.
    # @param [Hash] options A customizable set of options.
    # @option options [String] :name the name for the new key.
    # @param organization_slug [String] the slug of the organization the client keys belong to.
    # @return [SentryApi::ObjectifiedHash]
    def create_client_key(project_slug, options={}, organization_slug="")
      organization_slug = @default_org_slug if organization_slug == ""
      post("/projects/#{organization_slug}/#{project_slug}/keys/", body: options)
    end

    # Delete a Client Key.
    #
    # @example
    #   SentryApi.delete_client_key('project-slug','87c990582e07446b9907b357fc27730e')
    #
    # @param project_slug [String] the slug of the project the client keys belong to.
    # @param key_id [String] the ID of the key to delete.
    # @param organization_slug [String] the slug of the organization the client keys belong to.
    def delete_client_key(project_slug, key_id, organization_slug="")
      organization_slug = @default_org_slug if organization_slug == ""
      delete("/projects/#{organization_slug}/#{project_slug}/keys/#{key_id}/")
    end

    # Update a Client Key
    #
    # @example
    #   SentryApi.update_client_key('project-slug','87c990582e07446b9907b357fc27730e',{name:'new-name'})
    #
    # @param project_slug [String] the slug of the project the client keys belong to.
    # @param key_id [String] the ID of the key to update.
    # @param [Hash] options A customizable set of options.
    # @option options [String] :name the new name for the client key.
    # @param organization_slug [String] the slug of the organization the client keys belong to.
    # @return [Array<SentryApi::ObjectifiedHash>]
    def update_client_key(project_slug, key_id, options={}, organization_slug="")
      organization_slug = @default_org_slug if organization_slug == ""
      put("/projects/#{organization_slug}/#{project_slug}/keys/#{key_id}/", body: options)
    end

    # Return a list of sampled events bound to a project.
    #
    # @example
    #   SentryApi.project_events('project-slug')
    #
    # @param project_slug [String] the slug of the project the client keys belong to.
    # @param organization_slug [String] the slug of the organization the client keys belong to.
    # @return [Array<SentryApi::ObjectifiedHash>]
    def project_events(project_slug, organization_slug="")
      organization_slug = @default_org_slug if organization_slug == ""
      get("/projects/#{organization_slug}/#{project_slug}/events/")
    end

    # Retrieve an Event for a Project
    #
    # @example
    #   SentryApi.project_event('project-slug', 'event-id')
    #
    # @param project_slug [String] the slug of the project the client keys belong to.
    # @param event_id [String] the slug of the project the event belongs to.
    # @param organization_slug [String] the slug of the organization the client keys belong to.
    # @return [SentryApi::ObjectifiedHash]
    def project_event(project_slug, event_id, organization_slug="")
      organization_slug = @default_org_slug if organization_slug == ""
      get("/projects/#{organization_slug}/#{project_slug}/events/#{event_id}/")
    end

    # Return a list of aggregates bound to a project
    #
    # @example
    #   SentryApi.project_issues('project-slug')
    #
    # @return [Array<SentryApi::ObjectifiedHash>]
    def project_issues(project_slug, organization_slug="")
      organization_slug = @default_org_slug if organization_slug == ""
      get("/projects/#{organization_slug}/#{project_slug}/issues/")
    end

  end

end

class SentryApi::Client
  module Issues
    # List Issues
    #
    # @example
    #   SentryApi.project_issues('project-slug', {'query': 'is:unresolved Build-version:6.5.0'})
    #
    # @param project_slug [String] the slug of the project the client keys belong to.
    # @param [Hash] options A customizable set of options.  @option options [String] :statsPeriod an optional stat period (can be one of "24h", "14d", and "").
    # @option options [String] :query an optional Sentry structured search query. If not provided an implied "is:resolved" is assumed.)
    # @return [Array<SentryApi::ObjectifiedHash>]
    def issues(project_slug, options={})
      get("/projects/#{@default_org_slug}/#{project_slug}/issues/", query: options)
    end

    # Batch update issues
    #
    # @example
    #   SentryApi.update_client_key('project-slug', ['123', '456'], status:'ignored')
    #
    # @param project_slug [String] the slug of the project the client keys belong to.
    # @param issue_ids [Array] An array of issue ids which are to be updated.
    # @option options [Object] An object containing the issue fields which are to be updated.
    # @return [Array<SentryApi::ObjectifiedHash>]
    def batch_update_issues(project_slug, issue_ids=[], options={})
      put("/projects/#{@default_org_slug}/#{project_slug}/issues/?id=#{issue_ids.join('&id=')}", body: options)
    end
  end

end

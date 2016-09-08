class SentryApi::Client

  module Releases

    # Create a new release for the given project.
    # Releases are used by Sentry to improve it’s error reporting abilities by correlating first seen events with the release that might have introduced the problem.
    #
    # @example
    #   SentryApi.create_release('project-slug',{version:'1.0', ref:'6ba09a7c53235ee8a8fa5ee4c1ca8ca886e7fdbb'})
    #
    # @param project_slug [String] the slug of the project the client keys belong to.
    # @param [Hash] options A customizable set of options.
    # @option options [String] :version a version identifier for this release. Can be a version number, a commit hash etc.
    # @option options [String] :ref an optional commit reference. This is useful if a tagged version has been provided.
    # @option options [String] :url a URL that points to the release. This can be the path to an online interface to the sourcecode for instance.
    # @option options [Timestamp] :dateStarted an optional date that indicates when the release process started.
    # @option options [Timestamp] :dateReleased an optional date that indicates when the release went live. If not provided the current time is assumed.
    # @return <SentryApi::ObjectifiedHash>
    def create_release(project_slug, options={})
      post("/projects/#{@default_org_slug}/#{project_slug}/releases/", body: options)
    end

    # Permanently remove a release and all of its files.
    #
    # @example
    #   SentryApi.delete_release('project-slug','1.0')
    #
    # @param project_slug [String] the slug of the project to delete the release of.
    # @param version [String] the version identifier of the release.
    def delete_release(project_slug, version)
      delete("/projects/#{@default_org_slug}/#{project_slug}/releases/#{version}/")
    end

    # List a Project’s Releases
    #
    # @example
    #   SentryApi.releases('project-slug')
    #
    # @param project_slug [String] the slug of the project to list the releases of.
    # @return [Array<SentryApi::ObjectifiedHash>]
    def releases(project_slug)
      get("/projects/#{@default_org_slug}/#{project_slug}/releases/")
    end

    # Retrieve a Release
    #
    # @example
    #   SentryApi.release('project-slug','1.0')
    #
    # @param project_slug [String] the slug of the project to retrieve the release of.
    # @param version [String] the version identifier of the release.
    # @return <SentryApi::ObjectifiedHash>
    def release(project_slug, version)
      get("/projects/#{@default_org_slug}/#{project_slug}/releases/#{version}/")
    end

    # Update a Release
    #
    # @example
    #   SentryApi.update('project-slug', {ref:'6ba09a7c53235ee8a8fa5ee4c1ca8ca886e7fdbb'})
    #
    # @param project_slug [String] the slug of the project to retrieve the release of.
    # @param version [String] the version identifier of the release.
    # @option options [String] :ref an optional commit reference. This is useful if a tagged version has been provided.
    # @option options [String] :url a URL that points to the release. This can be the path to an online interface to the sourcecode for instance.
    # @option options [Timestamp] :dateStarted an optional date that indicates when the release process started.
    # @option options [Timestamp] :dateReleased an optional date that indicates when the release went live. If not provided the current time is assumed.
    # @return <SentryApi::ObjectifiedHash>
    def update_release(project_slug, version, options={})
      put("/projects/#{@default_org_slug}/#{project_slug}/releases/#{version}/", body: options)
    end

  end

end
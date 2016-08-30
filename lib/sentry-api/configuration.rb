module SentryApi
  # Defines constants and methods related to configuration.
  module Configuration
    # An array of valid keys in the options hash when configuring a Sentry::API.
    VALID_OPTIONS_KEYS = [:endpoint, :auth_token, :default_org_slug, :httparty].freeze

    # The user agent that will be sent to the API endpoint if none is set.
    DEFAULT_USER_AGENT = "Sentry Ruby Gem #{SentryApi::VERSION}".freeze

    # @private
    attr_accessor(*VALID_OPTIONS_KEYS)

    # Sets all configuration options to their default values
    # when this module is extended.
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block.
    def configure
      yield self
    end

    # Creates a hash of options and their values.
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Resets all configuration options to the defaults.
    def reset
      self.endpoint = ENV['SENTRY_API_ENDPOINT']
      self.auth_token = ENV['SENTRY_API_AUTH_TOKEN']
      self.default_org_slug = ENV['SENTRY_API_DEFAULT_ORG_SLUG']
    end

  end
end

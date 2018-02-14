module SentryApi
  # Wrapper for the Sentry REST API.
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each { |f| require f }

    include Organizations
    include Projects
    include Issues
    include Events
    include Teams
    include Releases
  end
end

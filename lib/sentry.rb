require 'sentry/version'
require 'sentry/objectified_hash'
require 'sentry/configuration'
require 'sentry/error'
require 'sentry/page_links'
require 'sentry/paginated_response'
require 'sentry/request'
require 'sentry/api'
require 'sentry/client'

module Sentry
  extend Configuration

  # Alias for Sentry::Client.new
  #
  # @return [Sentry::Client]
  def self.client(options={})
    Sentry::Client.new(options)
  end

  # Delegate to Sentry::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to Sentry::Client
  def respond_to_missing?(method_name, include_private = false)
    client.respond_to?(method_name) || super
  end

  # Delegate to HTTParty.http_proxy
  def self.http_proxy(address=nil, port=nil, username=nil, password=nil)
    Sentry::Request.http_proxy(address, port, username, password)
  end

  # Returns an unsorted array of available client methods.
  #
  # @return [Array<Symbol>]
  def self.actions
    hidden = /endpoint|auth_token|default_org_slug|get|post|put|delete|validate|set_request_defaults|httparty/
    (Sentry::Client.instance_methods - Object.methods).reject { |e| e[hidden] }
  end

end
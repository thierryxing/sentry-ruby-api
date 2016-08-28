# Sentry API

Sentry API is a Ruby wrapper for the [Sentry API](https://docs.sentry.io/hosted/api/). 
**And it still being developed, and not published yet.**

## Installation

Install it from rubygems:

add to a Gemfile:

```ruby
gem 'sentry', :path => '/path/to/sentry'
```

## Usage

Configuration example:

```ruby
Sentry.configure do |config|
  config.endpoint = 'http://example.com/api/0'
  config.auth_token = 'your_auth_token'
  config.default_org_slug = 'sentry-sc'
end
```

(Note: If you are using getsentry.com's hosted service, your endpoint will be `https://app.getsentry.com/api/0`)

Usage examples:

```ruby
# set an API endpoint
Sentry.endpoint = 'http://example.com/api/0'
# => "http://example.com/api/0"

# set a user private token
Sentry.auth_token = 'your_auth_token'
# => "your_auth_token"

# configure a proxy server
Sentry.http_proxy('proxyhost', 8888)
# proxy server w/ basic auth
Sentry.http_proxy('proxyhost', 8888, 'user', 'pass')

# list projects
Sentry.projects

# initialize a new client
s = Sentry.client(endpoint: 'https://api.example.com', auth_token: 'your_auth_token', default_org_slug: 'sentry-sc')

# a paginated response
projects = Sentry.projects

# check existence of the next page
projects.has_next_page?

# retrieve the next page
projects.next_page

# iterate all organizations
projects.auto_paginate do |project|
  # do something
end

# retrieve all projects as an array
projects.auto_paginate
```

## Development
The base frame had been finished, and more apis will be added soon. 
You are welcome to help me complete it.

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

## License

Released under the BSD 2-clause license. See LICENSE.txt for details.

## Special Thank
Thanks to NARKOZ's [gitlab](https://github.com/NARKOZ/gitlab) ruby wrapper, it really give me a lot of inspiration.

# Sentry Ruby API
[![Build Status](https://travis-ci.org/thierryxing/sentry-ruby-api.svg?branch=master)](https://travis-ci.org/thierryxing/sentry-ruby-api)
[![Gem Version](https://badge.fury.io/rb/sentry-api.svg)](https://badge.fury.io/rb/sentry-api)
[![License](https://img.shields.io/badge/license-BSD-red.svg?style=flat)](https://github.com/thierryxing/sentry-ruby-api/blob/master/LICENSE.txt)

Sentry Ruby API is a Ruby wrapper for the [getsentry/sentry API](https://docs.sentry.io/hosted/api/). 


## Installation
Install it from rubygems:

```sh
gem install sentry-api
```

Or add to a Gemfile:

```ruby
gem 'sentry-api'
```

## Usage

Configuration example:

```ruby
SentryApi.configure do |config|
  config.endpoint = 'http://example.com/api/0'
  config.auth_token = 'your_auth_token'
  config.default_org_slug = 'sentry-sc'
end
```

(Note: If you are using getsentry.com's hosted service, your endpoint will be `https://sentry.io/api/0/`)

Usage examples:

```ruby
# set an API endpoint
SentryApi.endpoint = 'http://example.com/api/0'
# => "http://example.com/api/0"

# set a user private token
SentryApi.auth_token = 'your_auth_token'
# => "your_auth_token"

# configure a proxy server
SentryApi.http_proxy('proxyhost', 8888)
# proxy server w/ basic auth
SentryApi.http_proxy('proxyhost', 8888, 'user', 'pass')

# list projects
SentryApi.projects

# initialize a new client
s = SentryApi.client(endpoint: 'https://api.example.com', auth_token: 'your_auth_token', default_org_slug: 'sentry-sc')

# a paginated response
projects = SentryApi.projects

# check existence of the next page
projects.has_next_page?

# retrieve the next page
projects.next_page

# iterate all projects
projects.auto_paginate do |project|
  # do something
end

# retrieve all projects as an array
projects.auto_paginate
```

## Development
After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

## License

Released under the BSD 2-clause license. See LICENSE.txt for details.

## Special Thank
Thanks to NARKOZ's [gitlab](https://github.com/NARKOZ/gitlab) ruby wrapper which really gives me a lot of inspiration.

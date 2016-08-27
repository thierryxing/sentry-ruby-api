# Sentry API

Gitlab is a Ruby wrapper and CLI for the [GitLab API](https://github.com/gitlabhq/gitlabhq/tree/master/doc/api#gitlab-api). 
**And it still being developed, and not published yet.**

## Installation

Install it from rubygems:

```sh
gem install sentry
```

Or add to a Gemfile:

```ruby
gem 'sentry'
```

## Usage

Configuration example:

```ruby
Sentry.configure do |config|
  config.endpoint = 'http://example.com/api/0'
  config.auth_token = 'your_auth_token'
  config.org_slug = 'sentry-sc'
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
Sentry.http_proxy('proxyhost', 8888, 'proxyuser', 'strongpasswordhere')

# list organizations
Sentry.organizations

# initialize a new client
s = Sentry.client(endpoint: 'https://api.example.com', auth_token: 'your_auth_token')

# a paginated response
organizations = Sentry.organizations

# check existence of the next page
organizations.has_next_page?

# retrieve the next page
organizations.next_page

# iterate all organizations
organizations.auto_paginate do |organization|
  # do something
end

# retrieve all organizations as an array
organizations.auto_paginate
```

## Development
The base frame had been finished, and more apis will be added soon. 
You are welcome to help me complete it.

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

## License

Released under the BSD 2-clause license. See LICENSE.txt for details.

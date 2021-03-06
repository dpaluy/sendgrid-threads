# Sendgrid Threads

Ruby Gem for the SendGrid Threads API https://threads.io/

This Gem allows you to send Threads events using native Ruby. For more details, read: https://docs.threads.io/

## Status

[![Gem Version](https://badge.fury.io/rb/sendgrid-threads.png)](http://badge.fury.io/rb/sendgrid-threads)
[![Build Status](https://secure.travis-ci.org/dpaluy/sendgrid-threads.png)](http://travis-ci.org/dpaluy/sendgrid-threads)
[![Code Climate](https://codeclimate.com/github/dpaluy/sendgrid-threads/badges/gpa.svg)](https://codeclimate.com/github/dpaluy/sendgrid-threads)
[![Dependency Status](https://gemnasium.com/dpaluy/sendgrid-threads.svg)](https://gemnasium.com/dpaluy/sendgrid-threads)
[![Test Coverage](https://codeclimate.com/github/dpaluy/sendgrid-threads/badges/coverage.svg)](https://codeclimate.com/github/dpaluy/sendgrid-threads/coverage)

## Installation

Add this line to your application's Gemfile:

`gem 'sendgrid-threads'`

And then execute:

`$ bundle`

Or install it yourself using:

`$ gem install sendgrid-threads`

## Usage

```
# config/initializers/sendgrid_threads.rb
SendgridThreads.configure do |config|
  config.key = 'my_api_key'
end
```

```
api = SendgridThreads::Api.new

# identify user
api.identify("unique_user_id", {email: "user@example.com", other: "parameters"})

# track event
api.track("unique_user_id", "Event name", {any: "custom", user: "properties"})

# track page view
api.page_view("unique_user_id", "Page name", {any: "custom", user: "properties"})

# remove user
api.remove("unique_user_id")

```

## Contributing to sendgrid-threads

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2015 David Paluy. See LICENSE.txt for further details.

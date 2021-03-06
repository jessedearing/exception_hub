# ExceptionHub

[![Build Status](https://secure.travis-ci.org/jessedearing/exception_hub.png?branch=master)](http://travis-ci.org/jessedearing/exception_hub)

ExceptionHub will take your applications exceptions as they are thrown
and will log them in Github issues.

Currently this gem is in alpha and not ready for production use.

## Installation

Add this line to your application's Gemfile:

    gem 'exception_hub'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install exception_hub

## Usage

### Rails

In Rails 3, you can run the rake task to enter in the information needed
for the initializer and it will fetch the Github token for you.

`rake exception_hub:generate_initializer`

The initializer needs the following fields:
* `github_api_token`
* `github_user_name`
* `repo_name`
* `repo_owner`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

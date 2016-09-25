# Kichi

Kichi is a simple commandline tool to manage application secrets for your applications using AWS.

To test different environments with different environment variables that contain sensitive information, it is a pain to keep having to export them, and sending them over chat programs to colleagues just makes it less secure.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kichi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kichi

## Usage

To use kichi with an S3 bucket, you need to have your aws credentials set up with `aws configure`

	$ kichi use s3

To use kichi with a directory

	$ kichi use path ~/secrets_directory --passphrase

To set environment variables

	$ kichi set USERNAME pikachu
	$ kichi set PASSWORD youwashock

To set files

	$ kichi file options.ini

To create a new environment

	$ kichi create my_env

To add environment variables to an environment

	$ kichi add USERNAME PASSWORD to my_env

To add a file to an environment

	$ kichi add options.ini to my_env

To list objects in an environment

	$ kichi list my_env

To run a program using an environment

	$ kichi in my_env run ./server

To delete an environment variable

	$ kichi unset USERNAME

To delete a file

	$ kichi rm options.ini

To delete an environment

	$ kichi delete my_env

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davidsiaw/kichi.


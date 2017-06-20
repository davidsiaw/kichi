# Kichi

Kichi is a simple commandline tool to manage application secrets for your applications using AWS.

Often you have shell scripts like:

```
USERNAME=mytzypdlk \
PASSWORD=aliceinwonderland1923 \
SENDGRID_USER=koouser \
SENDGRID_PASSWORD=koolpassword \
bash deploy.sh
```

Which are your important scripts to deploy your important services.

Sometimes you might even commit them by accident.

To test different environments with different environment variables that contain sensitive information, it is a pain to keep having to export them, and keeping files and updating them with your secrets around is a manual step no one needs to have. Even worse, sending them over chat programs and giving third parties access to your info.

Kichi reduces this to:

	$ kichi in my_env run bash deploy.sh

And you can provide your colleagues with AWS keys access to your secrets bucket and have them run this instead, without having to send secrets to them over third party services.

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

To set environment variables

	$ kichi set USERNAME pikachu
	$ kichi set PASSWORD youwashock

To view environment variables

	$ kichi get USERNAME
	USERNAME=pikachu

To set files

	$ kichi cp key.pem PRIVATE_KEY

> when you set a file, the env var will come up as PRIVATE_KEY_PATH. This env var will be your path to the actual file that was downloaded

To get files

	$ kichi dl PRIVATE_KEY
	File saved in PRIVATE_KEY

To create a new environment

	$ kichi create my_env

To add environment variables to an environment

	$ kichi add USERNAME my_env
	$ kichi add PASSWORD my_env
	
To add environment variables to an environment with a different name

	$ kichi add USERNAME my_env USER
	$ kichi add PASSWORD my_env PASS

To add a file to an environment

	$ kichi addfile PRIVATE_KEY my_env

To list the variable names in an environment

	$ kichi list my_env
	USERNAME
	PASSWORD
	PRIVATE_KEY_PATH

To run a program using an environment

	$ kichi in my_env run ./server


## Kichi

Kichi means "base" as in "military base" in Japanese. I chose the word because military bases generally have lots of secrets.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davidsiaw/kichi.


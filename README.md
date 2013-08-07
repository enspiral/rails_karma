# RailsKarma

This is a simple gem which integrates [Karma](http://karma-runner.github.io/) with Rails

[![Code Climate](https://codeclimate.com/github/enspiral/rails_karma.png)](https://codeclimate.com/github/enspiral/rails_karma)

## Installation

You will need npm to install karma so if you don't have node you can [get it here](http://nodejs.org/download/)

Add this line to your application's Gemfile:

    gem 'rails_karma'

Then execute:

    $ bundle
    $ rake karma:install

This will install a sample config file in config/karma.conf.js and install karma via npm

If you are using travis you will need `npm install` in your before_script to install karma e.g.

    #sample .travis.yml file
    language: ruby
    env:
      - DB=postgres
    rvm:
      - 2.0.0
    bundler_args: --without development
    before_script:
      - cp config/database.yml.travis config/database.yml
      - bundle exec rake db:setup
      - npm install

and then you can use karma in your rake task e.g.

    #lib/tasks/ci.rake
    desc "Run all the tests, called by the CI server"
    task :ci => [:spec, :cucumber, :karma] do

    end

## Usage

Update config/karma.conf.js to load the files you want to test and run `rake karma` to run your tests

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Changelog

### 0.1.3
- adding [angularjs-rails-resource](https://github.com/FineLinePrototyping/angularjs-rails-resource)
- adding test spec so rake karma works straight after install

### 0.1.2
- fixing error with shell command installing karma

### 0.1.1
- initial release

# Tilterview

## Usage

### Authorization

App uses HTTP Basic authentication specified by `config/settings/development.local.yml`

### GET /user/:user_id

Returns information about a Twitter user given a user id (not screenname).

### GET /user/:user_id/tweets

Returns the most recent tweets from a given user id.

### GET /user/:user_id/friends

Returns all of the users a given user is following (called "friends" by Twitter).

#### Parameters

`restrict_by_user_id`: filters the returned set of friends by the friends of another given user id.

## Server Installation

App uses Ruby 2.3.0 .

### Dependencies for OSX

1. Install either [rvm](rvm.io) or [rbenv](https://github.com/rbenv/rbenv) .
2. Compile and install Ruby 2.3.0 using their instructions

### App Installation

1. `bundle install`
2. Copy `config/settings/development.local.yml.example` to `config/settings/development.local.yml`
3. Fill in your Twitter application info and choose a HTTP basic auth username and password.

### App Execution

1. `rails s`

### Running test suite

1. `bundle exec rspec`
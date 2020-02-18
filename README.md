# README

This is an application to search Twitter through the API

## Ruby version
* Ruby version: 2.4.5
* Rails version: 5.2.4.1

## Installation
* Install Ruby on Rails (https://guides.rubyonrails.org/v5.0/getting_started.html)
* Git clone this repository
* Run bundle install
```
bundle install
```
* Setup the configuration (see Configuration)
* Start a rails server (in de application root folder)
```
rails s
```
* Go to http://localhost:3000/

## Configuration

* Create/edit a credentials file (this will create a encrypted credentials file and a master key if they don't exist yet.):

```
EDITOR=vim rails credentials:edit
```

* Go to https://www.timeanddate.com/services/api/ and create an account. Add you own timeanddate (xmltime) credentials to the incrypted credentials file. Do this for all the env you use:
```
xmltime:
  production:
    access_key: <access_key>
    secret_key: <secret_key>
  development:
    access_key: <access_key>
    secret_key: <secret_key>
  test:
    access_key: "access_key"
    secret_key: "secret_key"
```

## How to run the test suite

The test suite uses rspec. You can run the test suite by running rspec:
```
rspec
```

[ ![Codeship Status for bonyiii/bpe](https://app.codeship.com/projects/c28302e0-c6c5-0134-be7a-7a0e44e66932/status?branch=master)](https://app.codeship.com/projects/198707)

## Setting up

* `bundle install` to get all required gems
* `bundle exec rake db:create` to create the database
* `bundle exec rake db:setup` to create the database schema and seed data
* Set up your .env file.

## Log in

Two user seeded by default in the database:

* admin@test.com
* user@test.com

both user's password: password.

User admin@test.com has admin role, so access everything, the other one has limited rights.

## Running

`bundle exec rails s`

This will run the Rails server on <http://localhost:3000> 

## Explore API

Once the server is running, you can access <http://localhost:3000/swagger>
Tha api can be tested with swagger but only available after login.

## Heroku

The app deployed to: http://bpeboni.herokuapp.com/
The api explorer can be found here: http://bpeboni.herokuapp.com/swagger

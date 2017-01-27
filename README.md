[ ![Codeship Status for bonyiii/bpe](https://app.codeship.com/projects/c28302e0-c6c5-0134-be7a-7a0e44e66932/status?branch=master)](https://app.codeship.com/projects/198707)

## Setting up

* `bundle install` to get all required gems
* `bundle exec rake db:create` to create the database
* `bundle exec rake db:setup` to create the database schema and seed data
* Set up your .env file.

## Log in

Two user seeded by default in the database:

* admin@test.hu 
* user@test.hu 

both user's password: password.

User admin@test.hu has admin role, so access everything, the other one has limited rights.

Tha api can be tested with swagger which is available after login.


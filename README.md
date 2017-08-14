# README

* Ruby version

This project uses Ruby 2.4.1 and Rails 5.1.3.

* Configuration

`$ git clone git@github.com:katiekeel/rails-engine.git`
`$ bundle`

* Database creation

`$ bundle exec rake db:create`

* Database initialization

`$ bundle exec rake db:migrate`

* How to run the test suite

`$ rails g rspec:install`
`$ bundle exec rake db:test:prepare`
`$ rspec`

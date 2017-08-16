# RailsEngine

This project uses an API to access and analyze the [SalesEngine](https://github.com/turingschool-examples/sales_engine/tree/master/data) data.

### Versions

This project uses Ruby 2.4.1 and Rails 5.1.3.

### Setup

`$ git clone git@github.com:katiekeel/rails-engine.git`

### Configuration

`$ bundle`  
`$ rails g rspec:install`

### Database Setup

`$ bundle exec rake db:create`  
`$ bundle exec rake db:migrate`  
`$ rake import`

[More about rake tasks](https://github.com/ruby/rake)

### Testing

`$ bundle exec rake db:test:prepare`  
`$ rspec`

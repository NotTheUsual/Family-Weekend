source 'https://rubygems.org'

ruby '2.1.7'

gem 'sinatra'
gem 'rack-flash3'
gem 'sinatra-partial'

gem 'data_mapper'
gem 'dm-postgres-adapter'

gem 'carrierwave-datamapper'
gem 'mini_magick'
gem 'fog'

gem 'bcrypt'

gem 'haml'
gem 'sass'

group :development, :test do
  gem 'rspec'
  gem 'capybara'
  gem 'cucumber'
  gem 'cucumber-sinatra'
  gem 'database_cleaner', git: 'git://github.com/bmabey/database_cleaner'

  gem 'shotgun'
  gem 'foreman'
end

gem "codeclimate-test-reporter", group: :test, require: nil

group :staging, :production do
  gem 'thin'
end
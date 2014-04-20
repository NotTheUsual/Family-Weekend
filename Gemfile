source 'https://rubygems.org'

ruby '2.1.1'

gem 'sinatra'
gem 'rack-flash3'
gem 'sinatra-partial'

gem 'data_mapper'
gem 'dm-postgres-adapter'

gem 'bcrypt-ruby'

gem 'haml'
gem 'sass'

group :development, :test do
  gem 'rspec'
  gem 'capybara'
  # gem 'cucumber'
  gem 'cucumber-sinatra'
  gem 'database_cleaner', git: 'git://github.com/bmabey/database_cleaner'

  gem 'shotgun'
end

group :staging, :production do
  gem 'thin'
end
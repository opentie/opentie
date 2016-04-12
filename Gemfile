source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

# OR Mapper
# Use postgresql as the database for Active Record
gem 'pg'
gem 'activerecord'
gem 'activerecord-import'

# account authentication
gem 'devise'
gem 'devise-i18n'
gem 'bcrypt-ruby', '3.1.2'

# account authorization
gem 'cancancan'

# job queue
gem 'sidekiq'
gem 'sinatra', require: false
gem 'redis-namespace'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :assets do
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
end

group :development, :test do
  # need letter_opener_web
  gem 'jquery-rails'
  gem 'letter_opener_web'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # debugger
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'better_errors'

  # test
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
  gem 'guard'
  gem 'guard-rspec'
  gem 'spring-commands-rspec'
end

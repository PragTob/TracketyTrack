source 'http://rubygems.org'

gem 'rails', '3.1.3'

#gem 'sqlite3'
# PostgreSQL
gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# JavaScript runtime environment (required by rspc install)
gem 'therubyracer'

# Twitter bootstrap from anjlab
gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
  # Annotate models with the current db schema
  gem 'annotate', '~> 2.4.1.beta1'
  gem 'guard-rspec'
  gem 'libnotify'
end

group :test, :development do
  gem 'rspec-rails'
end

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'timecop'
end


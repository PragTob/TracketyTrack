source 'http://rubygems.org'

gem 'rails', '3.2.13'

# PostgreSQL
gem 'pg'

#allegedly better webserver than WEBRick
gem 'thin'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'googlecharts'
gem 'gravatar_image_tag'

# JavaScript runtime environment
gem 'therubyracer'

# Twitter bootstrap from anjlab
gem 'anjlab-bootstrap-rails', '~> 1.4', :require => 'bootstrap-rails'

gem 'travis-client'
# time durations
gem 'ruby-duration'

group :development do
  gem 'annotate', '~> 2.4.1.beta1'
  gem 'guard-rspec'
  gem 'libnotify'
end

group :test, :development do
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'timecop'
  gem 'turnip'
end


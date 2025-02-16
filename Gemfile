source "https://rubygems.org"

ruby "3.3.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

# auth
gem "devise", "~> 4.9"
gem "pundit", "~> 2.3"

# active-admin
gem "activeadmin", "~> 3.2"
gem "sass-rails", "~> 6.0"

# better urls
gem "friendly_id", "~> 5.5"

# charts
gem "chartkick", "~> 5.0"
gem "groupdate", "~> 6.4"

# background-jobs
gem "sidekiq", "~> 7.2"

# search, filter
gem "ransack", "~> 4.1"

# pagination
gem "pagy", "~> 8.6"

gem "active_storage_validations", "~> 1.1"

# audits
gem "audited", "~> 5.8"

gem "inline_svg", "~> 1.10"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
  
  # spec
  gem "rspec-rails", "~> 7.1"

  # Use factory-bot to replace fixtures
  gem "factory_bot_rails", "~> 6.4"

  gem "rails-controller-testing", "~> 1.0"

  # Load environment variables from .env
  gem "dotenv-rails", "~> 3.1"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Fix N+1 queries
  gem 'bullet'

  # mail previews
  gem "letter_opener", "~> 1.10"

  # Pretty print console
  gem 'awesome_print'

  # Use Rubocop to lint code
  gem 'rubocop-rails', require: false
  gem "rubocop-performance", "~> 1.23", require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"

  gem "shoulda-matchers", "~> 6.4"

  gem "rspec-retry", "~> 0.6.2"

  gem "database_cleaner-active_record", "~> 2.2"
end

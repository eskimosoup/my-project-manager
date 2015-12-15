source 'https://rubygems.org'

gem 'rails', github: "rails/rails"
gem 'sprockets-rails', github: "rails/sprockets-rails"
gem 'sprockets', github: "rails/sprockets"
gem 'sass-rails', github: "rails/sass-rails"
gem 'arel', github: "rails/arel"
gem 'rack', github: "rack/rack"

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# gem "autoprefixer-rails"
gem "normalize-rails", "~> 3.0.0"


group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "bundler-audit", require: false
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "i18n-tasks"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", github: "rspec/rspec-rails", branch: "rails-5-support-patches"
  gem "rspec-core", github: "rspec/rspec-core"
  gem "rspec-expectations", github: "rspec/rspec-expectations"
  gem "rspec-mocks", github: "rspec/rspec-mocks"
  gem "rspec-support", github: "rspec/rspec-support"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', github: 'rails/web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem "quiet_assets"
  gem "spring-commands-rspec"  
end

group :test do
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

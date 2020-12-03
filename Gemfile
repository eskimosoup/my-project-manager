source 'https://rubygems.org'

gem 'rails', '~> 4.2.11'
gem 'sass-rails'
gem 'optimadmin', git: 'git@github.com:eskimosoup/optimadmin.git'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

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

gem 'sprockets-rails', '2.2.3'
gem 'autoprefixer-rails'
gem 'normalize-rails', '~> 3.0.0'
gem 'simple_form'
gem 'administrate', '~> 0.2.2'
gem 'administrate-field-image'
gem 'bourbon', '~> 4.2', '>= 4.2.7'
gem 'clearance', '~> 1.12.0'
gem 'email_validator', '~> 1.6.0'
gem 'lograge', '~> 0.3.5'
gem 'pdfkit'
gem 'render_anywhere', '~> 0.0.12', require: false
# gem 'sidekiq', '~> 4.1'
gem 'friendly_id', '~> 5.1'
gem 'active_attr', '~> 0.9.0'
gem 'stripe', '~> 1.36', '>= 1.36.1'
gem 'wkhtmltopdf-binary'

group :development, :test do
  gem 'puma'
  gem 'awesome_print'
  gem 'bullet'
  gem 'bundler-audit', require: false
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'i18n-tasks'
  gem 'rspec-rails', '~> 3.4'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.2.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'
  gem 'quiet_assets'
  # gem 'spring-commands-rspec'
  gem 'optimadmin_generators', git: 'git@github.com:eskimosoup/optimadmin_generators.git'
  gem 'thin'
  gem 'annotate'
end

group :test do
  # gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'formulaic'
  gem 'launchy'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'webmock'
  gem 'pdf-reader'
  gem 'puffing-billy'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'jquery-ui-rails'
gem 'kaminari'

group :development do
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-passenger', require: false
end

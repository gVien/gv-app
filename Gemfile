source 'https://rubygems.org'
ruby "2.2.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Sass Bootstrap for Rails
gem 'bootstrap-sass', '~> 3.3.5'  #converts Less to Sass, since Rails asset pipeline supports the Sass language by default
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# devise helps with user authentication and authorization
gem 'devise'

# prawn is a pure Ruby PDF generation library. Using this to generate loan info into pdf
gem 'prawn', '~> 2.0', '>= 2.0.2'

# prawn separated table features into a separate gem
# see http://stackoverflow.com/questions/24455356/rails-prawn-undefined-method-table-for-prawndocument0x007fda2d594a98
gem "prawn-table"

# paperclip makes file upload easier, can be used with s3 or other cloud storage solution
gem "paperclip", "~> 4.3"

# gem to use with S3 storage
gem 'aws-sdk', '~> 1.6'

# friendly_id makes `/loan_applications/1` into a user friendly and user defined slug `/loan_applications/your-defined-slug`
gem 'friendly_id', '~> 5.1'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # better errors in front end to help with debugging
  gem "better_errors"

  # rspec helps writing test in rails application (will not use the default builtin Minitest)
  gem 'rspec-rails', '~> 3.4'

  # factory girl is a fixture (minitest) replacement
  gem 'factory_girl_rails'

  # Capybara works with rspec to write feature/integration test
  gem 'capybara'

  # cleans up test database and avoid conflict with capybara when thread connection isn't shared
  gem 'database_cleaner'

  # dot env for storing ENV variables (e.g. consumer key, access token, etc)
  gem 'dotenv-rails'

  # guard runs the test in the background so you don't have to type `be rspec spec` everytime
  gem 'guard-rspec', require: false
end

group :test, :darwin do
  # for OS/X only, waits for file changes from the Mac OS/X FSEvents API instead of polling the disk for changes.
  gem 'rb-fsevent'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'selenium-webdriver', '~> 2.48', '>= 2.48.1'
end

group :production do
  gem 'rails_12factor', '0.0.2'

  # replaces the WEBrick web server in production with puma
  gem 'puma',           '2.15.3'
end
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'active_model_serializers'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'file_validators'
gem 'jbuilder', '~> 2.7'
gem 'js-routes'
gem 'kaminari'
gem 'mini_magick'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4', '>= 6.1.4.4'
gem 'ransack', github: 'activerecord-hackery/ransack', branch: 'main'
gem 'responders'
gem 'sass-rails', '>= 6'
gem 'sidekiq', '~> 6.5'
gem 'sidekiq-failures'
gem 'sidekiq-throttled'
gem 'sidekiq-unique-jobs', '~> 7.1', '>= 7.1.33'
gem 'simple_form'
gem 'slim-rails'
gem 'state_machines'
gem 'state_machines-activerecord'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'virtus'
gem 'webpacker', '~> 5.0'
gem 'webpacker-react'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'rubocop'
end

group :development do
  gem 'bullet'
  gem 'letter_opener'
  gem 'letter_opener_web'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'simplecov', require: false
  gem 'simplecov-lcov', require: false
end

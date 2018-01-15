source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'bcrypt', '~> 3.1.7'
gem 'bunny'
gem 'coffee-rails', '~> 4.2'
gem 'httparty'
gem 'jbuilder', '~> 2.5'
gem 'jwt', '~> 1.0', '<= 1.5.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'redis', '3.3'
gem 'resque', '~> 1.25', '>= 1.25.2'
gem 'resque-scheduler'
gem 'sass-rails', '~> 5.0'
gem 'sneakers'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'dotenv-rails', groups: [:development, :test]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

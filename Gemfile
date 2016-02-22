source "https://rubygems.org"

gem "rails", "4.2.5"

gem "rails-api"
gem "active_model_serializers"
gem "spring", group: :development
gem "faker"

gem "jwt"
gem "pry"
gem "humanize_boolean"
gem "rspec-rails"
gem "byebug"
gem "bcrypt"
gem "codeclimate-test-reporter", group: :test
gem "apipie-rails"

group :development, :test do
  gem "rubocop", require: false
  gem "sqlite3"
  gem "factory_girl_rails"
  gem "shoulda-matchers", "~> 3.0"
  gem "simplecov"
end

group :production do
  gem "puma"
  gem "pg"
end

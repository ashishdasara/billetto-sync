source "https://rubygems.org"

gem "rails", "~> 8.0.2"
# Rails 8.0"s JSON encoder uses quirks_mode, which JSON 3 removed.
gem "json",         "< 3.0"
gem "propshaft"
gem "dartsass-rails"
gem "pg",           "~> 1.1"
gem "puma",         ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "kaminari",     "~> 1.2"
gem "clerk-sdk-ruby", require: "clerk"
gem "rails_event_store"

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "mission_control-jobs"

gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails", "~> 8.0.0"
end

group :development do
  gem "web-console"
  gem "bullet"
  gem "letter_opener"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

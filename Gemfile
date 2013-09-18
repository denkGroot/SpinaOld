source "http://rubygems.org"

gemspec

gem 'friendly_id', git: 'git@github.com:FriendlyId/friendly_id.git', branch: '5.0-stable'
gem 'spina-template', path: '~/Desktop/spina-template'
gem 'spina-themes-business', path: '~/Desktop/spina-themes-business'

group :development do
  gem 'pg'
  gem 'quiet_assets'
  gem 'letter_opener'
  gem 'brakeman'
end

group :production do
  gem 'sqlite3'
end

group :test do
  gem 'sqlite3'
end

source 'https://rubygems.org'

puppet_version = ENV.key?('PUPPET') ? ENV['PUPPET'] : ['>= 4.4.1']

group :validate do
  gem 'metadata-json-lint', '>= 1.0.0'
  gem 'puppet-lint', '>= 2.0.0'
end

group :documentation do
  gem 'puppet-strings', '>= 1.0.0'
end

group :acceptance do
  gem 'beaker-rspec', '>= 6.0.0'
end

group :unit do
  gem 'puppetlabs_spec_helper'
  gem 'puppet', puppet_version
  gem 'librarian-puppet'
end

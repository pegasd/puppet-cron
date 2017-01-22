source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : ['>= 4.4.1']
gem 'metadata-json-lint', '>= 1.0.0'
gem 'puppet-lint', '>= 2.0.0'

group :acceptance do
  gem 'beaker-rspec', '>= 6.0.0'
end

group :unit do
  gem 'puppetlabs_spec_helper'
  gem 'puppet', puppetversion
  gem 'librarian-puppet'
end

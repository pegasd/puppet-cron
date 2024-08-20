source 'https://rubygems.org'

group :development do
  gem 'puppet', ENV.fetch('PUPPET_GEM_VERSION', '>= 7.6.1')
  gem 'puppet-lint'
  gem 'metadata-json-lint'
  gem 'rspec-puppet-facts'
  gem 'rubocop-rspec'
end

group :development, :release_prep do
  gem 'puppet-strings'
  gem 'puppetlabs_spec_helper'
end

group :system_tests do
  gem 'puppet_litmus'
  gem 'CFPropertyList'
  gem 'serverspec'
end
# vim: syntax=ruby

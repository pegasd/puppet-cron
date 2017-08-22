source 'https://rubygems.org'

puppet_version = ENV.key?('PUPPET') ? ENV['PUPPET'] : ['~> 5.0']

group :validate do
  gem 'metadata-json-lint'
  gem 'puppet-lint'
  gem 'rubocop'
end

group :documentation do
  gem 'rgen'
  gem 'puppet-strings'
end

group :acceptance do
  gem 'sem_version'
  gem 'beaker-rspec'
  gem 'beaker-puppet_install_helper'
end

group :unit do
  gem 'semantic_puppet'
  gem 'puppetlabs_spec_helper'
  gem 'rspec-puppet-facts'
  gem 'puppet', puppet_version
end

source 'https://rubygems.org'

puppet_version = ENV.key?('PUPPET') ? ENV['PUPPET'] : ['~> 5.0']

group :acceptance do
  gem 'beaker-rspec'
  gem 'beaker-puppet_install_helper'
  gem 'sem_version'
end

group :documentation do
  gem 'puppet-strings'
  gem 'rgen'
end

group :unit do
  gem 'puppet', puppet_version
  gem 'puppetlabs_spec_helper'
  gem 'rspec-puppet-facts'
  gem 'semantic_puppet'
end

group :validate do
  gem 'metadata-json-lint'
  gem 'puppet-lint'
  gem 'sem_version'
end

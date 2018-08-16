# frozen_string_literal: true

source 'https://rubygems.org'

puppet_version = ENV.fetch('PUPPET', '~> 5')

group :acceptance do
  gem 'beaker'
  gem 'beaker-docker'
  gem 'beaker-puppet'
  gem 'beaker-rspec'
end

group :documentation do
  gem 'puppet-strings'
  gem 'rgen'
end

group :unit do
  gem 'puppet', puppet_version
  gem 'puppetlabs_spec_helper'
  gem 'rspec-puppet-facts'
end

group :validate do
  gem 'metadata-json-lint'
  gem 'puppet-lint'
  gem 'rubocop-rspec'
  gem 'sem_version'
  gem 'semantic_puppet'
  gem 'yamllint'
end

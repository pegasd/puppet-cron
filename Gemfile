# frozen_string_literal: true

source 'https://rubygems.org'

group :acceptance, optional: true do
  gem 'puppet_litmus', require: false
end

group :documentation do
  gem 'puppet-strings'
  gem 'rgen'
end

group :unit do
  gem 'puppet', ENV.fetch('PUPPET', '>= 4.4')
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

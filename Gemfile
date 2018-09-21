# frozen_string_literal: true

source 'https://rubygems.org'

group :ed25519 do
  gem 'bcrypt_pbkdf', '< 2.0'
  gem 'rbnacl', '< 5.0'
  gem 'rbnacl-libsodium'
end

group :acceptance do
  gem 'beaker-docker'
  gem 'beaker-puppet', '= 1.1.0'
  gem 'beaker-rspec'
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

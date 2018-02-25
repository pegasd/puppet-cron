# frozen_string_literal: true

require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'sem_version'

puppet_version = ENV.fetch('PUPPET_VERSION', '~> 5.0')
install_puppet_from_gem_on(hosts, version: puppet_version)

RSpec.configure do |c|
  c.color     = true
  c.formatter = :documentation

  c.before :suite do
    hosts.each do |host|
      copy_root_module_to(host, module_name: 'cron', target_module_path: '/etc/puppetlabs/code/modules')
      on host, puppet('module', 'install', 'puppetlabs-stdlib')
    end
  end
end

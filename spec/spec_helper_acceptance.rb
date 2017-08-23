require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'sem_version'

ENV['PUPPET_INSTALL_TYPE'] = 'agent' if ENV['PUPPET_INSTALL_TYPE'].nil?

if ENV['PUPPET_INSTALL_TYPE'] == 'gem'
  puppet_version = ENV['PUPPET_VERSION'] || '~> 4.0'
  install_puppet_from_gem_on(hosts, version: puppet_version)
else
  run_puppet_install_helper unless ENV['BEAKER_provision'] == 'no'
end

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

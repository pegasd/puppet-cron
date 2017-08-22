require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'sem_version'

ENV['PUPPET_INSTALL_TYPE'] = 'agent' if ENV['PUPPET_INSTALL_TYPE'].nil?

# Otherwise puppet defaults to /etc/puppetlabs/code
configure_defaults_on hosts, 'foss' unless ENV['PUPPET_INSTALL_TYPE'] == 'agent'

if ENV['PUPPET_INSTALL_TYPE'] == 'gem'
  install_puppet_from_gem_on(
    hosts,
    :version => (
    ENV['PUPPET_INSTALL_VERSION'] || ENV['PUPPET_VERSION'] || '~> 4.0'
    )
  )
else
  run_puppet_install_helper unless ENV['BEAKER_provision'] == 'no'
end

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.color     = true
  c.formatter = :documentation

  c.before :suite do
    hosts.each do |host|
      copy_module_to(host, :source => proj_root, :module_name => 'cron')
      on host, puppet('module', 'install', 'puppetlabs-stdlib')
    end
  end
end

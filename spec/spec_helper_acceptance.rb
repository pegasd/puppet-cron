# frozen_string_literal: true

require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'sem_version'

puppet_version = ENV.fetch('PUPPET', '~> 5.0')
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

# This runs the supplied manifest twice on the host.
#
# First time checking for failures.
# Second time checking for changes.
#
# Idempotent and clean. Just the way I like it.
def apply_and_test_idempotence(manifest)
  context 'applying manifest and testing for idempotence' do
    it 'does not fail the first time around' do
      apply_manifest(manifest, catch_failures: true)
    end

    it 'does not change anything on the second run' do
      apply_manifest(manifest, catch_changes: true)
    end
  end
end

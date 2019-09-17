# frozen_string_literal: true

require 'serverspec'
require 'puppet_litmus'
include PuppetLitmus # rubocop:disable Style/MixinUsage

RSpec.configure do |c|
  c.color     = true
  c.formatter = :documentation
end

if ENV['TARGET_HOST'].nil? || ENV['TARGET_HOST'] == 'localhost'
  puts 'Running tests against this machine !'
  set :backend, :exec
else
  inventory_hash = inventory_hash_from_inventory_file
  node_config = config_from_node(inventory_hash, ENV['TARGET_HOST'])

  if target_in_group(inventory_hash, ENV['TARGET_HOST'], 'ssh_nodes')
    set :backend, :ssh
    options = Net::SSH::Config.for(host)
    options[:user] = node_config.dig('ssh', 'user') unless node_config.dig('ssh', 'user').nil?
    options[:port] = node_config.dig('ssh', 'port') unless node_config.dig('ssh', 'port').nil?
    options[:password] = node_config.dig('ssh', 'password') unless node_config.dig('ssh', 'password').nil?
    options[:verify_host_key] = Net::SSH::Verifiers::Always.new unless node_config.dig('ssh', 'host-key-check').nil?
    host = ENV['TARGET_HOST'].split(':').first
    set :host,        options[:host_name] || host
    set :ssh_options, options
    set :request_pty, true
  end
end

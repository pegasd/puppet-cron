# frozen_string_literal: true

require 'puppet_litmus'
require 'yaml'

include PuppetLitmus

def pre_run
  # install necessary deps for running further tests
  return run_shell('yum install cronie -y') if os[:family] == 'redhat' && os[:release].to_i == 7
  return run_shell('apt-get install cron -y') if os[:family] == 'debian' || os[:family] == 'ubuntu'
  nil
end

RSpec.configure

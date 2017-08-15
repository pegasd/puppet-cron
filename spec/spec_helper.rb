require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
include RspecPuppetFacts

RSpec.configure do |c|
  c.formatter = :documentation
  c.color     = true
  c.after(:suite) do
    RSpec::Puppet::Coverage.report!
  end
end

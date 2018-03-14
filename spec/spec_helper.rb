# frozen_string_literal: true

require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.formatter     = :documentation
  c.default_facts = { osfamily: 'Debian' }
  c.after(:suite) { RSpec::Puppet::Coverage.report! }
end

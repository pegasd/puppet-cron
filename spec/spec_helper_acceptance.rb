# frozen_string_literal: true

require 'puppet_litmus'
require 'spec_helper_acceptance_local' if File.file?(File.join(File.dirname(__FILE__), 'spec_helper_acceptance_local.rb'))

PuppetLitmus.configure!

RSpec.configure do |c|
  c.formatter = :documentation
  c.color     = true
end

# Whether the machine under test is FreeBSD.
#
# `litmus:acceptance:localhost` runs rspec on the target itself, so `uname` is
# authoritative and, unlike litmus's `fact` helper, is available at file-load
# time (i.e. in `describe`/metadata scope, where these guards are evaluated).
def freebsd_target?
  `uname -s`.strip == 'FreeBSD'
end

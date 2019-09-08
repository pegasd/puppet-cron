# frozen_string_literal: true

require 'puppet_litmus'
include PuppetLitmus

RSpec.configure do |c|
  c.color     = true
  c.formatter = :documentation
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

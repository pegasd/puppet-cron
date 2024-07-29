# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'cron::whitelist' do
  pp = <<~PUPPET

    class { 'cron':
      purge_crond => true,
    }

    cron::whitelist { 'cant_touch_this': }

  PUPPET

  context 'fake a cron job and see that it is not purged' do
    apply_and_test_idempotence(pp)

    describe command('echo hello > /etc/cron.d/cant_touch_this') do
      its(:exit_status) { is_expected.to eq 0 }
    end

    it 'does not bork the whitelisted cron job' do
      apply_manifest(pp, catch_changes: true)
    end

    describe file('/etc/cron.d/cant_touch_this') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match(%r{^hello$}) }
    end
  end
end

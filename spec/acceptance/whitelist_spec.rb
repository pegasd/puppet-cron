# frozen_string_literal: true

require 'spec_helper_acceptance'

# /etc/cron.d is a Linux vixie-cron concept; the FreeBSD base cron does not read it.
describe 'cron::whitelist', unless: freebsd_target? do
  describe 'fake a cron job and see that it is not purged' do
    let(:pp) do
      <<~PUPPET
        class { 'cron':
          purge_crond => true,
        }
        cron::whitelist { 'cant_touch_this': }
      PUPPET
    end

    it 'behaves idempotently' do
      idempotent_apply(pp)
    end

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

# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'tidy cron::job' do
  describe 'first run with two cron::job resources' do
    pp = <<~PUPPET

      include cron

      cron::job { 'backup':
        command => '/usr/bin/backup';
      }

      cron::job { 'other-backup':
        command => '/usr/bin/other-backup';
      }

    PUPPET

    it 'does not fail' do
      apply_manifest(pp, catch_failures: true)
    end

    it 'is idempotent' do
      apply_manifest(pp, catch_changes: true)
    end

    describe cron do
      it { is_expected.to have_entry '* * * * * /usr/bin/backup' }
      it { is_expected.to have_entry '* * * * * /usr/bin/other-backup' }
    end

    describe service('cron') do
      it { is_expected.to be_running }
    end

    describe package('cron') do
      it { is_expected.to be_installed }
    end
  end

  describe 'second run with one of the resources removed' do
    pp = <<~PUPPET

      include cron

      cron::job { 'backup':
        command => '/usr/bin/backup';
      }

    PUPPET

    it 'does not fail' do
      apply_manifest(pp, catch_failures: true)
    end

    it 'is idempotent' do
      apply_manifest(pp, catch_changes: true)
    end

    describe cron do
      it { is_expected.to have_entry '* * * * * /usr/bin/backup' }
      it { is_expected.not_to have_entry '* * * * * /usr/bin/other-backup' }
    end
  end

  describe 'whitelist a cron job in /etc/cron.d' do
    pp = <<~PUPPET

      class { 'cron':
        purge_crond => true,
      }

      cron::whitelist { 'cant_touch_this': }

    PUPPET

    it 'does not fail' do
      apply_manifest(pp, catch_failures: true)
    end

    it 'is idempotent' do
      apply_manifest(pp, catch_changes: true)
    end

    describe command('echo hello > /etc/cron.d/cant_touch_this') do
      its(:exit_status) { is_expected.to eq 0 }
    end

    it 'does not bork the whitelisted cron job' do
      apply_manifest(pp, catch_changes: true)
    end
    describe command('cat /etc/cron.d/cant_touch_this') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to match(/^hello$/) }
    end
  end

  describe 'clean up with ensure => absent' do
    pp = <<~PUPPET
      class { 'cron': ensure => absent }
    PUPPET

    it 'does not fail' do
      apply_manifest(pp, catch_failures: true)
    end

    it 'is idempotent' do
      apply_manifest(pp, catch_changes: true)
    end

    describe service('cron') do
      it { is_expected.not_to be_running }
    end

    describe package('cron') do
      it { is_expected.not_to be_installed }
    end

    absent_files = %w[
      /etc/cron.d
      /etc/cron.deny
      /etc/cron.allow
    ]

    absent_files.each do |absent_file|
      describe file(absent_file) do
        it { is_expected.not_to exist }
      end
    end
  end
end

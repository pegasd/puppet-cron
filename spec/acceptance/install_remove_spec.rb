# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'cron' do
  context 'installs?' do
    pp = <<~PUPPET

      include cron

    PUPPET

    apply_and_test_idempotence(pp)

    describe package('cron') do
      it { is_expected.to be_installed }
    end

    describe service('cron') do
      it { is_expected.to be_running }
    end

    describe file('/etc/cron.d') do
      it { is_expected.to exist }
      it { is_expected.to be_directory }
    end

    describe file('/etc/cron.allow') do
      it { is_expected.to exist }
      its(:content) { is_expected.to eq('') }
    end

    describe file('/etc/cron.deny') do
      it { is_expected.not_to exist }
    end
  end

  context 'removes?' do
    pp = <<~PUPPET

      class { 'cron':
        ensure => absent
      }

    PUPPET

    apply_and_test_idempotence(pp)

    describe package('cron') do
      it { is_expected.not_to be_installed }
    end

    describe service('cron') do
      it { is_expected.not_to be_running }
    end

    managed_files = ['/etc/cron.allow', '/etc/cron.deny', '/etc/cron.d']

    managed_files.each do |absent_file|
      describe file(absent_file) do
        it { is_expected.not_to exist }
      end
    end
  end
end

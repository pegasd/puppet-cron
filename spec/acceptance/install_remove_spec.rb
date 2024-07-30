# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'cron' do
  describe 'installs?' do
    let(:pp) do
      <<~PUPPET

        include cron

      PUPPET
    end

    idempotent_apply(pp)

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

  describe 'removes?' do
    let(:pp) do
      <<~PUPPET

        class { 'cron':
          ensure => absent
        }

      PUPPET
    end

    idempotent_apply(pp)

    describe package('cron') do
      it { is_expected.not_to be_installed }
    end

    describe service('cron') do
      it { is_expected.not_to be_running }
    end

    ['/etc/cron.allow', '/etc/cron.deny', '/etc/cron.d'].each do |absent_file|
      describe file(absent_file) do
        it { is_expected.not_to exist }
      end
    end
  end
end

# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'cron' do
  freebsd = freebsd_target?

  # cron ships in the FreeBSD base system and uses /var/cron/{allow,deny}
  # rather than a managed package and /etc/cron.{allow,deny}.
  cron_allow = freebsd ? '/var/cron/allow' : '/etc/cron.allow'
  cron_deny  = freebsd ? '/var/cron/deny'  : '/etc/cron.deny'

  describe 'installs?' do
    let(:pp) { 'include cron' }

    it 'behaves idempotently' do
      idempotent_apply(pp)
    end

    unless freebsd
      describe package('cron') do
        it { is_expected.to be_installed }
      end

      describe file('/etc/cron.d') do
        it { is_expected.to exist }
        it { is_expected.to be_directory }
      end
    end

    describe service('cron') do
      it { is_expected.to be_running }
    end

    describe file(cron_allow) do
      it { is_expected.to exist }
      # On FreeBSD cron.allow governs root too, so root is listed to keep cron
      # usable; on Linux root is implicit and the file is empty by default.
      if freebsd
        its(:content) { is_expected.to match(%r{^root$}) }
      else
        its(:content) { is_expected.to eq('') }
      end
    end

    describe file(cron_deny) do
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

    it 'behaves idempotently' do
      idempotent_apply(pp)
    end

    unless freebsd
      describe package('cron') do
        it { is_expected.not_to be_installed }
      end
    end

    describe service('cron') do
      it { is_expected.not_to be_running }
    end

    [cron_allow, cron_deny, '/etc/cron.d'].each do |absent_file|
      describe file(absent_file) do
        it { is_expected.not_to exist }
      end
    end
  end
end

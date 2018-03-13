# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'crontab(1)' do
  context 'luke is not ready yet' do
    pp = <<~PUPPET

      include cron

      user { 'luke': ensure => present }

    PUPPET

    apply_and_test_idempotence pp

    describe command('sudo -u luke env EDITOR=cat crontab -e') do
      its(:exit_status) { is_expected.to eq 1 }
      its(:stderr) { is_expected.to match(/^You \(luke\) are not allowed to use this program \(crontab\)$/) }
    end
  end

  context 'luke has force' do
    pp = <<~PUPPET

      class { 'cron':
        allowed_users => [ 'luke' ],
      }

      user { 'luke': ensure => present }

    PUPPET

    apply_and_test_idempotence pp

    describe command('sudo -u luke env EDITOR=cat crontab -e') do
      its(:exit_status) { is_expected.to eq 0 }
    end
  end

  context 'clean up' do
    pp = <<~PUPPET

      include cron

      user { 'luke': ensure => absent }

    PUPPET

    apply_and_test_idempotence pp

    describe user('luke') do
      it { is_expected.not_to exist }
    end
  end
end

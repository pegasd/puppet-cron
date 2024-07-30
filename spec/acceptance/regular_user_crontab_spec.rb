# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'crontab(1)' do
  describe 'luke is not ready yet' do
    let(:pp) do
      <<~PUPPET
        package { 'sudo': ensure => present }
        include cron
        user { 'luke': ensure => present }
      PUPPET
    end

    it 'behaves idempotently' do
      idempotent_apply(pp)
    end

    describe command('sudo -u luke env EDITOR=cat crontab -e') do
      its(:exit_status) { is_expected.to eq 1 }
      its(:stderr) { is_expected.to match(%r{^You \(luke\) are not allowed to use this program \(crontab\)$}) }
    end
  end

  describe 'luke has force' do
    let(:pp) do
      <<~PUPPET
        package { 'sudo': ensure => present }
        class { 'cron':
          allowed_users => [ 'luke' ],
        }
        user { 'luke': ensure => present }
      PUPPET
    end

    it 'behaves idempotently' do
      idempotent_apply(pp)
    end

    describe command('sudo -u luke env EDITOR=cat crontab -e') do
      its(:exit_status) { is_expected.to eq 0 }
    end
  end

  describe 'clean up' do
    let(:pp) do
      <<~PUPPET
        package { 'sudo': ensure => absent }
        include cron
        user { 'luke': ensure => absent }
      PUPPET
    end

    it 'behaves idempotently' do
      idempotent_apply(pp)
    end

    describe user('luke') do
      it { is_expected.not_to exist }
    end
  end
end

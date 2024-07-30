# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'first run with two cron::job resources' do
  let(:pp) do
    <<~PUPPET

      include cron

      cron::job { 'backup':
        command => '/usr/bin/backup';
      }

      cron::job { 'other-backup':
        command => '/usr/bin/other-backup';
      }

    PUPPET
  end

  idempotent_apply(pp)

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
  let(:pp) do
    <<~PUPPET

      include cron

      cron::job { 'backup':
        command => '/usr/bin/backup';
      }

    PUPPET
  end

  idempotent_apply(pp)

  describe cron do
    it { is_expected.to have_entry '* * * * * /usr/bin/backup' }
    it { is_expected.not_to have_entry '* * * * * /usr/bin/other-backup' }
  end
end

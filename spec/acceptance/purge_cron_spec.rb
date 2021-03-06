# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'cron::purge' do
  context 'first run with two cron::job resources' do
    pp = <<~PUPPET

      include cron

      cron::job { 'backup':
        command => '/usr/bin/backup';
      }

      cron::job { 'other-backup':
        command => '/usr/bin/other-backup';
      }

    PUPPET

    apply_and_test_idempotence(pp)

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

  context 'second run with one of the resources removed' do
    pp = <<~PUPPET

      include cron

      cron::job { 'backup':
        command => '/usr/bin/backup';
      }

    PUPPET

    apply_and_test_idempotence(pp)

    describe cron do
      it { is_expected.to have_entry '* * * * * /usr/bin/backup' }
      it { is_expected.not_to have_entry '* * * * * /usr/bin/other-backup' }
    end
  end
end

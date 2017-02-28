require 'spec_helper_acceptance'

describe 'tidy cron::job' do

  describe 'first run with two cron::job resources' do
    pp = <<-EOS

class { 'cron': dir_mode => '0750' }

cron::job {
  'backup':
    command => '/usr/bin/backup';
  'other-backup':
    command => '/usr/bin/other-backup';
}

    EOS

    it 'is idempotent' do
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe cron do
      it { is_expected.to have_entry '* * * * * /usr/bin/backup' }
      it { is_expected.to have_entry '* * * * * /usr/bin/other-backup' }
    end

  end

  describe 'second run with one of the resources removed' do
    pp = <<-EOS

include cron

cron::job { 'backup':
  command => '/usr/bin/backup';
}

    EOS

    it 'is idempotent' do
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe cron do
      it { is_expected.to have_entry '* * * * * /usr/bin/backup' }
      it { is_expected.not_to have_entry '* * * * * /usr/bin/other-backup' }
    end

  end

end

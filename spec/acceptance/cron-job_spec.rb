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
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file('/etc/cron.d') do
      it { is_expected.to be_directory }
      it { is_expected.to be_mode 750 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
    end
    describe file('/etc/cron.d/backup') do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 644 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
    end
    describe file('/etc/cron.d/other-backup') do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 644 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
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
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file('/etc/cron.d') do
      it { is_expected.to be_directory }
      it { is_expected.to be_mode 755 }
    end
    describe file('/etc/cron.d/backup') do
      it { is_expected.to be_file }
    end
    describe file('/etc/cron.d/other-backup') do
      it { is_expected.to_not exist }
    end

  end

end
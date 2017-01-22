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

    it 'should be idempotent' do
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to eq 2
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to eq 0
    end

    describe file('/etc/cron.d') do
      it { should be_directory }
      it { should be_mode 750 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
    describe file('/etc/cron.d/job_backup') do
      it { should be_file }
      it { should be_mode 644 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
    describe file('/etc/cron.d/job_other-backup') do
      it { should be_file }
      it { should be_mode 644 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end

  describe 'second run with one of the resources removed' do
    pp = <<-EOS

cron::job { 'backup':
  command => '/usr/bin/backup';
}

    EOS

    it 'should be idempotent' do
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to eq 2
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to eq 0
    end

    describe file('/etc/cron.d') do
      it { should be_directory }
      it { should be_mode 755 }
    end
    describe file('/etc/cron.d/job_backup') do
      it { should be_file }
    end
    describe file('/etc/cron.d/job_other-backup') do
      it { should_not exist }
    end
  end

end
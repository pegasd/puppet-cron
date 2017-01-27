require 'spec_helper_acceptance'

describe 'tidy cron::incron_job' do
  describe 'first run with incron enabled' do
    pp = <<-EOS
class { 'cron': use_incron => true }
    EOS

    it 'is idempotent' do
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file('/etc/incron.d') do
      it { is_expected.to be_directory }
      it { is_expected.to be_mode 755 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
    end

    describe package('incron') do
      it { is_expected.to be_installed }
    end
    describe service('incron') do
      it { is_expected.to be_running }
    end
  end

  describe 'two incron jobs' do
    pp = <<-EOS
class { 'cron': use_incron => true }

cron::incron_job {
  'mv_file':
    path => '/var/chroot/sftp_user/upload',
    event => 'IN_CLOSE_WRITE',
    command => 'mv "$@/$# /tmp"';
  'process_rotated_log':
    path => '/var/log/upload_logs',
    event => 'IN_MOVED_TO',
    command => '/usr/bin/process_log';
}
    EOS

    it 'is idempotent' do
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file('/etc/incron.d/mv_file') do
      its (:content) { is_expected.to match /\/var\/chroot\/sftp_user\/upload IN_CLOSE_WRITE mv "\$\@\/\$\# \/tmp"/ }
    end
    describe file('/etc/incron.d/process_rotated_log') do
      its (:content) { is_expected.to match /\/var\/log\/upload_logs IN_MOVED_TO \/usr\/bin\/process_log/ }
    end
  end

  describe 'now we kill incron' do
    pp = <<-EOS
include cron
    EOS

    it 'is idempotent' do
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe package('incron') do
      it { is_expected.not_to be_installed }
    end

    describe file('/etc/incron.d') do
      it { is_expected.not_to exist }
    end
  end

end
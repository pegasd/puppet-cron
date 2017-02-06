require 'spec_helper'

describe 'cron::incron_job'

describe 'cron::incron_job' do
  let(:title) { 'process_file' }

  context 'with minimal parameters' do
    let(:params) { {
      :command => '/usr/bin/process_file',
      :path    => '/storage/incoming/upload',
      :event   => 'IN_CLOSE_WRITE',
    } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('cron') }
    it { is_expected.to contain_file('/etc/incron.d/process_file').with_content(
      /^\/storage\/incoming\/upload IN_CLOSE_WRITE \/usr\/bin\/process_file$/
    ) }
  end

  context 'with custom file permissions' do
    let(:params) { {
      :command => '/usr/bin/process_file',
      :path    => '/storage/upload',
      :event   => 'IN_MOVED_TO',
      :mode    => '0600',
    } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('cron') }
    it { is_expected.to contain_file('/etc/incron.d/process_file').with(
      :owner => 'root',
      :group => 'root',
      :mode  => '0600',
    ).with_content(/^\/storage\/upload IN_MOVED_TO \/usr\/bin\/process_file$/) }
  end

  context 'with unsupported inotify event' do
    let(:params) { {
      :command => '/usr/bin/backup',
      :path    => '/some/path',
      :event   => 'IN_CREATE',
    } }

    it do
      expect {
        is_expected.to compile
      }.to raise_error(/expects a match for Enum/)
    end
  end

end

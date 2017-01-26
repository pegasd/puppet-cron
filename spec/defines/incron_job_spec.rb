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

    it { is_expected.to compile }
    it { is_expected.to contain_file('/etc/incron.d/process_file').with_content(
      /^\/storage\/incoming\/upload IN_CLOSE_WRITE \/usr\/bin\/process_file$/
    )}
  end
end

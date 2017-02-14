require 'spec_helper'

describe 'cron::job' do
  let(:title) { 'backup' }

  context 'job with default values' do
    let(:params) { {
      command: '/usr/bin/backup',
    } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_file('/etc/cron.d/backup').with(
      ensure:  :file,
      owner:   'root',
      group:   'root',
      mode:    '0644',
      content: /^\* \* \* \* \* root \/usr\/bin\/backup$/)
    }
  end

  context 'with custom launch time' do
    let(:params) { {
      command: '/usr/bin/backup',
      minute:  [50, 20], # This should be sorted to '20,50'
      hour:    [1, 5, 1], # This should be uniq'd to '1,5'
      weekday: '*/2',
    } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_file('/etc/cron.d/backup').with(
      ensure:  :file,
      owner:   'root',
      group:   'root',
      mode:    '0644',
      content: /^20,50 1,5 \* \* \*\/2\ root \/usr\/bin\/backup$/
    ) }
  end

  context 'with custom user' do
    let(:params) { {
      command: '/usr/bin/backup',
      user:    'pegas',
    } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_file('/etc/cron.d/backup').with(
      ensure:  :file,
      owner:   'root',
      group:   'root',
      mode:    '0644',
      content: /^\* \* \* \* \* pegas \/usr\/bin\/backup$/
    ) }
  end

  context 'with minute => 66' do
    let(:params) { {
      command: '/usr/bin/backup',
      minute:  66,
    } }

    it { is_expected.to compile.and_raise_error(/Error while evaluating.*, got Integer.* at/) }
  end

end

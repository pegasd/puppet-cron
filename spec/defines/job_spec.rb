require 'spec_helper'

describe 'cron::job' do
  let(:title) { 'backup' }

  context 'job with default values' do
    let(:params) { {
      command: '/usr/bin/backup',
    } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_cron('backup').with(
      ensure:   :present,
      user:     'root',
      command:  '/usr/bin/backup',
      minute:   '*',
      hour:     '*',
      month:    '*',
      monthday: '*',
      weekday:  '*',
    ) }
  end

  context 'with custom launch time' do
    let(:params) { {
      command: '/usr/bin/backup',
      minute:  [50, 20, 50, 20], # This should be sorted to '20,50'
      hour:    [1, 5, 1], # This should be uniq'd to '1,5'
      month:   '*/2',
      weekday: '0-4',
    } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_cron('backup').with(
      ensure:   :present,
      user:     'root',
      command:  '/usr/bin/backup',
      minute:   [50, 20],
      hour:     [1, 5],
      month:    '*/2',
      monthday: '*',
      weekday:  '0-4',
    ) }
  end

  context 'with custom user' do
    let(:params) { {
      command: '/usr/bin/backup',
      user:    'pegas',
    } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_cron('backup').with(
      ensure:   :present,
      user:     'pegas',
      command:  '/usr/bin/backup',
      minute:   '*',
      hour:     '*',
      month:    '*',
      monthday: '*',
      weekday:  '*',
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

# frozen_string_literal: true

require 'spec_helper'

describe 'cron::job' do
  let(:title) { 'backup' }

  context 'job with default values' do
    let(:params) { { command: '/usr/bin/backup' } }

    it { is_expected.to compile.with_all_deps }
    it {
      is_expected.to contain_cron('backup').with(
        ensure:   :present,
        user:     'root',
        command:  '/usr/bin/backup',
        minute:   '*',
        hour:     '*',
        month:    '*',
        monthday: '*',
        weekday:  '*',
      )
    }
  end

  context 'with custom launch time' do
    let(:params) do
      {
        command: '/usr/bin/backup',
        minute:  [50, 20, 50, 20],
        hour:    [1, 5, 1],
        month:   '*/2',
        weekday: '0-4',
      }
    end

    it { is_expected.to compile.with_all_deps }
    it {
      is_expected.to contain_cron('backup').with(
        ensure:   :present,
        user:     'root',
        command:  '/usr/bin/backup',
        minute:   [50, 20],
        hour:     [1, 5],
        month:    '*/2',
        monthday: '*',
        weekday:  '0-4',
      )
    }
  end

  context 'with custom user' do
    let(:params) do
      {
        command: '/usr/bin/backup',
        user:    'pegas',
      }
    end

    it { is_expected.to compile.with_all_deps }
    it {
      is_expected.to contain_cron('backup').with(
        ensure:   :present,
        user:     'pegas',
        command:  '/usr/bin/backup',
        minute:   '*',
        hour:     '*',
        month:    '*',
        monthday: '*',
        weekday:  '*',
      )
    }
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe 'cron::job' do
  let(:title) { 'backup' }
  let(:params) { { command: '/usr/bin/backup' } }

  context 'job with default values' do
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

  context 'with ensure => absent' do
    let(:params) { { ensure: :absent }.merge(super()) }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_cron('backup').with_ensure(:absent) }
  end

  context 'with custom launch time' do
    let(:params) do
      {
        minute:  [50, 20],
        hour:    [1, 5],
        month:   '*/2',
        weekday: '0-4',
      }.merge(super())
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
    let(:params) { { user: 'pegas' }.merge(super()) }

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

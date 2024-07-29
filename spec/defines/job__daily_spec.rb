# frozen_string_literal: true

require 'spec_helper'

describe 'cron::job::daily' do
  let(:title) { 'backup' }
  let(:params) { { command: 'echo hi' } }

  context 'with minimal parameters' do
    it { is_expected.to compile.with_all_deps }
    it {
      is_expected.to contain_cron__job('backup')
        .only_with(
          ensure:   :present,
          command:  'echo hi',
          minute:   0,
          hour:     0,
          monthday: '*',
          month:    '*',
          weekday:  '*',
          user:     'root',
        )
    }
  end

  context 'with ensure => absent' do
    let(:params) { { ensure: :absent }.merge(super()) }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_cron('backup').with_ensure(:absent) }
  end

  context 'with custom minute and hour' do
    let(:params) { { minute: 34, hour: 5 }.merge(super()) }

    it { is_expected.to compile.with_all_deps }
    it {
      is_expected.to contain_cron__job('backup')
        .only_with(
          ensure:   :present,
          command:  'echo hi',
          minute:   34,
          hour:     5,
          monthday: '*',
          month:    '*',
          weekday:  '*',
          user:     'root',
        )
    }
  end

  context 'with custom user' do
    let(:params) { { user: 'luke' }.merge(super()) }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_cron__job('backup').with_user('luke') }
  end
end

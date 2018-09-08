# frozen_string_literal: true

require 'spec_helper'

describe 'cron::job::weekly' do
  let(:title) { 'backup' }
  let(:params) { { command: 'echo hi' } }

  context 'with minimal parameters' do
    it { is_expected.to compile.with_all_deps }
    it {
      is_expected.to contain_cron__job('backup')
        .only_with(
          command:  'echo hi',
          minute:   0,
          hour:     0,
          monthday: '*',
          month:    '*',
          weekday:  0,
          user:     'root',
        )
    }
  end

  context 'with custom minute, hour, and weekday' do
    let(:params) { { minute: 34, hour: 5, weekday: 3 }.merge(super()) }

    it { is_expected.to compile.with_all_deps }
    it {
      is_expected.to contain_cron__job('backup')
        .only_with(
          command:  'echo hi',
          minute:   34,
          hour:     5,
          monthday: '*',
          month:    '*',
          weekday:  3,
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

# frozen_string_literal: true

require 'spec_helper'

describe 'cron::job::monthly' do
  let(:title) { 'backup' }
  let(:params) { { command: 'echo hi' } }

  it { is_expected.to compile.with_all_deps }
  it {
    is_expected.to contain_cron__job('backup')
      .with_command('echo hi')
      .with_minute(0)
      .with_hour(0)
      .with_monthday(1)
      .with_month('*')
      .with_weekday('*')
  }
end

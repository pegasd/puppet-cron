# frozen_string_literal: true

require 'spec_helper'

describe 'cron::hourly' do
  let(:title) { 'backup' }
  let(:params) { { command: 'echo hi' } }

  it { is_expected.to compile.with_all_deps }
  it { is_expected.to contain_cron__job('backup') }
end

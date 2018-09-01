# frozen_string_literal: true

require 'spec_helper'

describe 'cron::hourly' do
  let(:title) { 'backup' }
  it { is_expected.to compile.with_all_deps }
end

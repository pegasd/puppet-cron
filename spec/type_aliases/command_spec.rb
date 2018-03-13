# frozen_string_literal: true

require 'spec_helper'

describe 'Cron::Command' do
  describe 'reject multiline commands' do
    it { is_expected.not_to allow_value("my\ncommand") }
    it { is_expected.not_to allow_value("mycommand\n") }
    it { is_expected.not_to allow_value("\nmycommand") }
  end
end

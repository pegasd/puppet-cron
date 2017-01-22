require 'spec_helper'

describe 'cron' do
  context 'with default values for all parameters' do
    it { should contain_class('cron') }
  end
end

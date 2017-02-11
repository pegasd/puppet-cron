require 'spec_helper'

describe 'cron::whitelist' do
  let(:title) { 'whitelisted' }

  context 'with default parameters' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_file('/etc/cron.d/whitelisted').with(
      ensure:  :file,
      replace: false,
    ) }
  end
end

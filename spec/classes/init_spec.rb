require 'spec_helper'

describe 'cron' do
  context 'with default values for all parameters' do
    it { should contain_class('cron') }
    it { should contain_file('/etc/cron.d').with({
      :ensure  => 'directory',
      :owner   => 'root',
      :group   => 'root',
      :mode    => '0755',
      :recurse => true,
      :purge   => true,
    }) }
  end

  context 'with custom dir permissions' do
    let (:params) { { :dir_mode => '0750' } }

    it { should contain_file('/etc/cron.d').with({
      :mode => '0750'
    }) }
  end
end

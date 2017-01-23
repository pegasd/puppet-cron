require 'spec_helper'

describe 'cron' do

  context 'with default values for all parameters' do
    it { should contain_file('/etc/cron.d').with({
      :ensure  => 'directory',
      :owner   => 'root',
      :group   => 'root',
      :mode    => '0755',
      :recurse => true,
      :purge   => true,
    }) }

    it { should contain_file('/etc/incron.d').with({
      :ensure => 'absent',
      :force  => true,
    }) }
  end

  context 'with custom dir permissions' do
    let (:params) { {
      :dir_mode   => '0750',
      :use_incron => true,
    } }

    it { should contain_file('/etc/cron.d').with({ :mode => '0750' }) }
    it { should contain_file('/etc/incron.d').with({ :mode => '0750' }) }
  end

  context 'with incron enabled' do
    let (:params) { { :use_incron => true } }

    it { should contain_file('/etc/incron.d').with({
      :ensure  => 'directory',
      :owner   => 'root',
      :group   => 'root',
      :mode    => '0755',
      :recurse => true,
      :purge   => true,
    }) }

    it { should contain_service('incron').with({
      :ensure     => 'running',
      :enable     => true,
      :hasrestart => true,
      :hasstatus  => true,
      :require    => "Package['incron']",
    }) }

    it { should contain_package('incron').with({
      :ensure => 'present',
    }) }
  end

end

require 'spec_helper'

describe 'cron' do

  context 'with default values for all parameters' do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('cron') }
    it { is_expected.to contain_file('/etc/cron.d').with(
      :ensure  => :directory,
      :owner   => 'root',
      :group   => 'root',
      :mode    => '0755',
      :recurse => true,
      :purge   => true,
    ) }
    it { is_expected.to contain_file('/etc/incron.d').with(
      :ensure => :absent,
      :force  => true,
    ) }
    it { is_expected.to contain_package('incron').with(:ensure => :absent) }
  end

  context 'with custom dir permissions' do
    let(:params) { {
      :crond_mode   => '0750',
      :incrond_mode => '0750',
      :use_incron   => true,
    } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_file('/etc/cron.d').with(:mode => '0750') }
    it { is_expected.to contain_file('/etc/incron.d').with(:mode => '0750') }
  end

  context 'with incron enabled' do
    let(:params) { { :use_incron => true } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_file('/etc/incron.d').with(
      :ensure  => :directory,
      :owner   => 'root',
      :group   => 'root',
      :mode    => '0755',
      :recurse => true,
      :purge   => true,
    ) }

    it { is_expected.to contain_service('incron').with(
      :ensure     => :running,
      :enable     => true,
      :hasrestart => true,
      :hasstatus  => true,
      :require    => 'Package[incron]'
    ) }

    it { is_expected.to contain_package('incron').with(:ensure => :present) }
  end

end

require 'spec_helper'

describe 'cron' do

  context 'with default values for all parameters' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('cron') }

    it { is_expected.to contain_class('cron::install') }
    it { is_expected.to contain_class('cron::config') }
    it { is_expected.to contain_class('cron::service') }

    describe 'cron::install' do
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_package('cron').with_ensure(:present) }
    end

    describe 'cron::config' do
      it { is_expected.to contain_file('/etc/cron.d').with(
        ensure:  :directory,
        owner:   'root',
        group:   'root',
        mode:    '0755',
        recurse: true,
        purge:   true,
      ) }
    end

    describe 'cron::service' do
      it { is_expected.to contain_service('cron').with(
        ensure: :running,
        enable: true,
      ) }
    end
  end

  context 'with custom dir_mode' do
    let(:params) { { dir_mode: '0700' } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_file('/etc/cron.d').with(mode: '0700') }
  end

  context 'with ensure => absent' do
    let(:params) { { ensure: 'absent' } }

    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('cron::remove') }

    it { is_expected.not_to contain_class('cron::install') }
    it { is_expected.not_to contain_class('cron::config') }
    it { is_expected.not_to contain_class('cron::service') }

    it { is_expected.to contain_file('/etc/cron.d').with(
      :ensure => :absent,
      :force  => true,
    ) }
    it { is_expected.to contain_package('cron').with_ensure(:absent) }
  end

end

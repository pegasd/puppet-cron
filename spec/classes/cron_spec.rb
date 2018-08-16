# frozen_string_literal: true

require 'spec_helper'

describe 'cron' do
  context 'with default values for all parameters' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('cron') }

    it { is_expected.to contain_class('cron::install') }
    it { is_expected.to contain_class('cron::config') }
    it { is_expected.to contain_class('cron::purge') }
    it { is_expected.to contain_class('cron::service') }

    describe 'cron::install' do
      it { is_expected.to contain_package('cron').with_ensure(:installed) }
    end

    describe 'cron::config' do
      it { is_expected.to contain_file('/etc/cron.deny').with_ensure(:absent).with_force(true) }
      it {
        is_expected.to contain_file('/etc/cron.allow').only_with(
          ensure:  :file,
          force:   true,
          content: '',
          owner:   'root',
          group:   'root',
          mode:    '0644',
        )
      }
    end

    describe 'cron::service' do
      it { is_expected.to contain_service('cron') }
    end

    describe 'cron::purge' do
      it { is_expected.to contain_resources('cron').only_with(purge: true) }
      it { is_expected.not_to contain_file('/etc/cron.d') }
    end
  end

  context 'service management' do
    context 'default behavior' do
      it { is_expected.to compile.with_all_deps }
      it {
        is_expected.to contain_service('cron').only_with(
          ensure:     :running,
          enable:     true,
          hasrestart: true,
          hasstatus:  true,
        )
      }
    end

    context 'do not manage the service' do
      let(:params) { { service_manage: false } }
      it { is_expected.to compile.with_all_deps }
      it { is_expected.not_to contain_service('cron') }
    end

    context 'ensure => stopped' do
      let(:params) { { service_ensure: :stopped } }
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_service('cron').with_ensure(:stopped) }
    end

    context 'enable => false' do
      let(:params) { { service_enable: false } }
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_service('cron').with_enable(false) }
    end
  end

  context 'with purge_crond => true' do
    let(:params) { { purge_crond: true } }

    it { is_expected.to compile.with_all_deps }

    describe 'cron::config' do
      it {
        is_expected.to contain_file('/etc/cron.d').only_with(
          ensure:  :directory,
          owner:   'root',
          group:   'root',
          mode:    '0755',
          recurse: true,
          purge:   true,
          force:   true,
        )
      }
    end
  end

  context 'with ensure => absent' do
    let(:params) { { ensure: 'absent' } }

    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('cron::remove') }

    it { is_expected.not_to contain_class('cron::install') }
    it { is_expected.not_to contain_class('cron::config') }
    it { is_expected.not_to contain_class('cron::purge') }
    it { is_expected.not_to contain_class('cron::service') }

    it { is_expected.not_to contain_class('cron::service') }

    removed_files = ['/etc/cron.d', '/etc/cron.deny', '/etc/cron.allow']

    removed_files.each do |removed_file|
      it {
        is_expected.to contain_file(removed_file).only_with(
          ensure: :absent,
          force:  true,
        )
      }
    end
    it { is_expected.to contain_package('cron').with_ensure(:absent) }
  end

  context 'with purge_noop => true' do
    let(:params) { { purge_noop: true } }

    it {
      is_expected.to contain_resources('cron')
        .with_purge(true)
        .with_noop(true)
    }
  end

  context 'with allowed users specified' do
    let(:params) { { allowed_users: ['good_dude', 'good_chick'] } }

    it { is_expected.to compile.with_all_deps }

    it {
      is_expected.to contain_file('/etc/cron.allow').with(
        ensure:  :file,
        content: <<~CRON_ALLOW,
          good_dude
          good_chick
        CRON_ALLOW
      )
    }

    it { is_expected.to contain_file('/etc/cron.deny').with_ensure(:absent) }
  end

  context 'with denied users specified' do
    let(:params) { { denied_users: ['bad_dude', 'bad_chick'] } }

    it { is_expected.to compile.with_all_deps }

    it {
      is_expected.to contain_file('/etc/cron.deny').only_with(
        ensure:  :file,
        force:   true,
        owner:   'root',
        group:   'root',
        mode:    '0644',
        content: <<~CRON_DENY,
          bad_dude
          bad_chick
        CRON_DENY
      )
    }

    it { is_expected.to contain_file('/etc/cron.allow').with_ensure(:absent) }
  end

  context 'fail when both allowed and denied users specified' do
    let(:params) do
      {
        allowed_users: ['good_dude', 'good_chick'],
        denied_users:  ['bad_dude', 'bad_chick'],
      }
    end

    it { is_expected.to compile.and_raise_error(/Either allowed or denied cron users must be specified, not both./) }
  end

  context 'with custom package version' do
    let(:params) { { package_version: '3.0pl1-124ubuntu2' } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_package('cron').with_ensure('3.0pl1-124ubuntu2') }
  end

  context 'with purge_cron => false' do
    let(:params) { { purge_cron: false } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.not_to contain_resources('cron') }
  end

  context 'with allow_all_users => true' do
    let(:params) { { allow_all_users: true } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_file('/etc/cron.allow').with_ensure(:absent).with_force(true) }
    it {
      is_expected.to contain_notify('purge_users_crontabs')
        .with_message("WARNING! Users' crontabs will be purged. Disable purge_cron or allow_all_users.")
    }
  end
end

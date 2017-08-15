require 'spec_helper'

describe 'cron' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

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
          it { is_expected.to contain_resources('cron').with_purge(true) }
          it { is_expected.not_to contain_file('/etc/cron.d') }
        end

        describe 'cron::service' do
          it {
            is_expected.to contain_service('cron')
              .only_with(
                ensure: :running,
                enable: true,
              ) }
        end
      end

      context 'with purge_crond => true' do
        let(:params) { { purge_crond: true } }

        it { is_expected.to compile.with_all_deps }

        describe 'cron::config' do
          it {
            is_expected.to contain_file('/etc/cron.d')
              .only_with(
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
        it { is_expected.not_to contain_class('cron::service') }

        it {
          is_expected.to contain_file('/etc/cron.d')
            .only_with(
              ensure: :absent,
              force:  true,
            )
        }
        it { is_expected.to contain_package('cron').with_ensure(:absent) }
      end

    end
  end
end
require 'spec_helper'

describe 'cron::job' do
  let(:title) { 'backup' }

  context 'job with default values' do
    let(:params) { {
      :command => '/usr/bin/backup',
    } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_file('/etc/cron.d/backup').with(
      :ensure => :file,
      :owner  => 'root',
      :group  => 'root',
      :mode   => '0644',
    ).with_content(/^\* \* \* \* \* root \/usr\/bin\/backup$/) }
  end

  context 'with custom launch time' do
    let(:params) { {
      :command => '/usr/bin/backup',
      :minute  => [50, '20'],
      :hour    => [1, 5],
      :weekday => '*/2',
    } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_file('/etc/cron.d/backup').with(
      :ensure => :file,
      :owner  => 'root',
      :group  => 'root',
      :mode   => '0644',
    ).with_content(/^50,20 1,5 \* \* \*\/2 root \/usr\/bin\/backup$/) }
  end

  context 'with minute => 66' do
    let(:params) { {
      :command => '/usr/bin/backup',
      :minute  => 66,
    } }

    it do
      expect {
        is_expected.to compile
      }.to raise_error(/Error while evaluating.*, got Integer.* at/)
    end
  end

end

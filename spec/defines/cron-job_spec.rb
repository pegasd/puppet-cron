require 'spec_helper'

describe 'cron::job' do
  let(:title) { 'backup' }

  context 'job with default values' do
    let(:params) { {
      :command => '/usr/bin/backup',
    } }

    it { should compile }
    it { should contain_file('cron-job_backup').with({
      :ensure => 'file',
      :owner  => 'root',
      :group  => 'root',
      :mode   => '0644',
    }).with_content(/^* * * * * root \/usr\/bin\/backup$/) }
  end

  context 'with custom launch time' do
    let(:params) { {
      :command => '/usr/bin/backup',
      :minute  => [50, '20'],
      :hour    => [1, 5],
      :weekday => 3,
    } }

    it { should compile }
  end

  context 'with incorrect launch time' do
    let(:params) { {
      :command => '/usr/bin/backup',
      :minute  => 66,
    } }

    it { should_not compile }
  end
end
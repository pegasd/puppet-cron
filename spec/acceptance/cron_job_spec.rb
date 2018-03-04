# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'cron::job' do
  context 'creates cron::job' do
    pp = <<~PUPPET

      include cron

      cron::job { 'ping_stuff':
        command => 'echo hi >> /tmp/say_hi',
      }

    PUPPET

    apply_and_test_idempotence(pp)
  end

  context 'cron job works' do
    describe command('sleep 60') do
      its(:exit_status) { is_expected.to eq 0 }
    end

    describe file('/tmp/say_hi') do
      it { is_expected.to exist }
      it { is_expected.to be_file }
      its(:content) { is_expected.to match(/^hi$/) }
    end
  end

  context 'clean up after myself' do
    pp = <<~PUPPET

      file { '/tmp/say_hi':
        ensure  => absent,
      }

      include cron

    PUPPET

    apply_and_test_idempotence(pp)

    describe file('/tmp/say_hi') do
      it { is_expected.not_to exist }
    end
  end
end

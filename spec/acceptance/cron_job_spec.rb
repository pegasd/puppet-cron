# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'cron::job' do
  describe 'creates cron::job' do
    let(:pp) do
      <<~PUPPET

        include cron

        cron::job { 'ping_stuff':
          command => 'echo hi > /tmp/say_hi',
        }

      PUPPET
    end

    it 'behaves idempotently' do
      idempotent_apply(pp)
    end

    describe cron do
      it { is_expected.to have_entry '* * * * * echo hi > /tmp/say_hi' }
    end

    context 'cron job works' do
      describe command('sleep 60') do
        its(:exit_status) { is_expected.to eq 0 }
      end

      describe file('/tmp/say_hi') do
        it { is_expected.to exist }
        it { is_expected.to be_file }
        its(:content) { is_expected.to match(%r{^hi$}) }
      end
    end
  end

  describe 'clean up after myself' do
    let(:pp) do
      <<~PUPPET

        file { '/tmp/say_hi':
          ensure  => absent,
        }

        include cron

      PUPPET
    end

    it 'behaves idempotently' do
      idempotent_apply(pp)
    end

    describe file('/tmp/say_hi') do
      it { is_expected.not_to exist }
    end

    describe cron do
      it { is_expected.not_to have_entry '* * * * * echo hi > /tmp/say_hi' }
    end
  end
end

require 'spec_helper'

describe 'Cron::User' do
  context 'allow valid users' do
    [
      'luke',
      'root',
      'pegas',
    ].each do |valid_username|
      it { is_expected.to allow_value(valid_username) }
    end
  end

  context 'reject invalid users' do
    [
      '',
      {},
      [],
      "\n",
      "hi\n",
    ].each do |invalid_username|
      it { is_expected.not_to allow_value(invalid_username) }
    end
  end
end

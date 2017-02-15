require 'spec_helper'

describe 'type_class::monthday', type: :class do
  describe 'accept integer values' do
    [1, 02, 7, 9, 11, 15, 23, 28, 31].each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }
        it { is_expected.to compile }
      end
    end
  end
  describe 'accept integer arrays' do
    [
      [1, 3, 7, 9, 25, 28],
      [14, 28], [15, 30],
      [7, 14, 21, 28],
    ].each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }
        it { is_expected.to compile }
      end
    end
  end
  describe 'accept only *' do
    %w(*).each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }
        it { is_expected.to compile }
      end
    end
  end
  describe 'reject incorrect values' do
    [
      '*/2', '*/5', '00-05', '0-05', '*/0', [], [''], '',
      '*/1', '*/24', '24', -1, 32, 0, '2-23/24', '*/*', '34',
    ].each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }

        it { is_expected.to compile.and_raise_error(/parameter 'value'.*expects/) }
      end
    end
  end
end

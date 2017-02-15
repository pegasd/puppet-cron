require 'spec_helper'

describe 'type_class::weekday', type: :class do
  describe 'accept integer values' do
    [1, 02, 3, 6].each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }
        it { is_expected.to compile }
      end
    end
  end
  describe 'accept integer arrays' do
    [
      [0, 1, 2, 3, 4], [5, 6], [0, 3],
      [0, 1, 2, 3], [0], [2], [5], [6],
    ].each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }
        it { is_expected.to compile }
      end
    end
  end
  describe 'accept expressions like *, */2, 0-4/2, 0-4' do
    %w(* 0-4 5-6 */2 0-4/2).each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }
        it { is_expected.to compile }
      end
    end
  end
  describe 'reject incorrect values' do
    [
      '*/*', '*/0', '*/1', '1', '6', -1, 7, 34, [], [''], ''
    ].each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }
        it { is_expected.to compile.and_raise_error(/parameter 'value'.*expects/) }
      end
    end
  end
end

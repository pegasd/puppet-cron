require 'spec_helper'

describe 'type_class::hour', type: :class do
  describe 'accept integer values' do
    [0, 1, 02, 15, 23].each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }
        it { is_expected.to compile }
      end
    end
  end
  describe 'accept integer arrays' do
    [
      [0, 3, 7, 15, 22],
      [0, 3, 6, 9, 12, 15, 18, 21],
      [0, 12],
      [1, 2, 3, 4],
    ].each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }
        it { is_expected.to compile }
      end
    end
  end
  describe 'accept values similar to *, */2, 1-23/2, 11-23' do
    %w(* 0-5 11-23 5-11 1-23 19-22 */2 */23 */11 1-23/2 12-23/3 2-20/4).each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }
        it { is_expected.to compile }
      end
    end
  end
  describe 'reject incorrect values' do
    [
      '00-05', '0-05', '*/0', '*/1', '*/24', '24', 24, -1,
      '2-23/24', '*/*', '34'
    ].each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }
        it { is_expected.to compile.and_raise_error(/parameter 'value' expects a value of type/) }
      end
    end
  end
end

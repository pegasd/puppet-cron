require 'spec_helper'

describe 'type_class::minute', type: :class do
  describe 'accept integer values' do
    [0, 1, 02, 15, 27, 34, 59].each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }
        it { is_expected.to compile }
      end
    end
  end
  describe 'accept integer arrays' do
    [
      [0, 3, 7, 15, 22],
      [0, 15, 30, 45],
      [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55],
      [0, 10, 20, 30, 40, 50],
      [1, 2, 3, 4]
    ].each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }
        it { is_expected.to compile }
      end
    end
  end
  describe 'accept expressions like *, */5, 1-59/5, 10-40' do
    %w(* */5 */10 */59 */3 1-59/5 10-40 2-59/10).each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }
        it { is_expected.to compile }
      end
    end
  end
  describe 'reject incorrect values' do
    [
      '*/0', '*/1', '*/60', '60', '10-400',
      60, -1, '2-59/60', '*/*', '34', '*/*',
      [], [''], ''
    ].each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }
        it { is_expected.to compile.and_raise_error(/parameter 'value'.*expects/) }
      end
    end
  end
end

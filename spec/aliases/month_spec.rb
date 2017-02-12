require 'spec_helper'

describe 'type_class::month', type: :class do
  describe 'accept integer values' do
    [1, 02, 3, 7, 12].each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }
        it { is_expected.to compile }
      end
    end
  end
  describe 'accept integer arrays' do
    [
      [2, 4, 6, 8, 10, 12],
      [3, 6, 9, 12],
      [1, 4, 7, 11], [6, 12],
      [12], [1]
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
      '*/*', '*/0', '*/1', '1', '12', '1-12',
      '1-12/2', '*/2', -1, 0, 13, 34,
    ].each do |value|
      context "with #{value}" do
        let(:params) { { value: value } }
        it { is_expected.to compile.and_raise_error(/parameter 'value' expects a value of type/) }
      end
    end
  end
end

require 'spec_helper'

describe 'Cron::Monthday' do
  describe 'accept integer values' do
    [1, 02, 7, 9, 11, 15, 23, 28, 31].each do |value|
      it { is_expected.to allow_value(value) }
    end
  end
  describe 'accept integer arrays' do
    [
      [1, 3, 7, 9, 25, 28],
      [14, 28], [15, 30],
      [7, 14, 21, 28],
    ].each do |value|
      it { is_expected.to allow_value(value) }
    end
  end
  describe 'accept only *' do
    %w(* */2 */30).each do |value|
      it { is_expected.to allow_value(value) }
    end
  end
  describe 'reject incorrect values' do
    [
      '00-05', '0-05',
      [], [''], '',
      '*/0', '*/1', '*/31',
      '1', '30', '34', '-1', '0',
      -1, 32, 0,
      '2-23/24', '*/*',
    ].each do |value|
      it { is_expected.not_to allow_value(value) }
    end
  end
end

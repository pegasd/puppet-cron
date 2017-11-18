# frozen_string_literal: true

require 'spec_helper'

describe 'Cron::Month' do
  describe 'accept integer values' do
    [1, 2, 3, 7, 12].each do |value|
      it { is_expected.to allow_value(value) }
    end
  end
  describe 'accept integer arrays' do
    [
      [2, 4, 6, 8, 10, 12],
      [3, 6, 9, 12],
      [1, 4, 7, 11],
      [6, 12],
    ].each do |value|
      it { is_expected.to allow_value(value) }
    end
  end
  describe 'accept expressions like * and */2' do
    %w[* */2 */3].each do |value|
      it { is_expected.to allow_value(value) }
    end
  end
  describe 'reject incorrect values' do
    [
      '*/*', '*/0', '*/1', '1', '12', '1-12',
      '1-12/2', -1, 0, 13, 34, [], [''], '', [12], [1]
    ].each do |value|
      it { is_expected.not_to allow_value(value) }
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe 'Cron::Weekday' do
  describe 'accept integer values' do
    [1, 2, 3, 6].each do |value|
      it { is_expected.to allow_value(value) }
    end
  end
  describe 'accept integer arrays' do
    [
      [0, 1, 2, 3, 4], [5, 6], [0, 3],
      [0, 1, 2, 3]
    ].each do |value|
      it { is_expected.to allow_value(value) }
    end
  end
  describe 'accept expressions like *, */2, 0-4/2, 0-4' do
    ['*', '0-4', '5-6', '*/2', '0-4/2'].each do |value|
      it { is_expected.to allow_value(value) }
    end
  end
  describe 'reject incorrect values' do
    [
      '*/*', '*/0', '*/1', '1', '6', -1, 7, 34, [], [''], '', [0], [2], [5], [6]
    ].each do |value|
      it { is_expected.not_to allow_value(value) }
    end
  end
end

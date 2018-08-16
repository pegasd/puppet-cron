# frozen_string_literal: true

require 'spec_helper'

describe 'Cron::Minute' do
  describe 'accept integer values' do
    [0, 1, 2, 15, 27, 34, 59].each do |value|
      it { is_expected.to allow_value(value) }
    end
  end
  describe 'accept integer arrays' do
    [
      [0, 3, 7, 15, 22],
      [0, 15, 30, 45],
      [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55],
      [0, 10, 20, 30, 40, 50],
      [1, 2, 3, 4],
    ].each do |value|
      it { is_expected.to allow_value(value) }
    end
  end
  describe 'accept expressions like *, */5, 1-59/5, 10-40' do
    ['*', '*/5', '*/10', '*/59', '*/3', '1-59/5', '10-40', '2-59/10'].each do |value|
      it { is_expected.to allow_value(value) }
    end
  end
  describe 'accept arrays of valid expressions' do
    [
      ['0-32', '*/5'],
      ['0-15', '*/3', 23],
      [25, 27, '0-3', '*/18'],
    ].each do |value|
      it { is_expected.to allow_value(value) }
    end
  end
  describe 'reject incorrect values' do
    [
      '*/0', '*/1', '*/60', '60', '10-400',
      60, -1, '2-59/60', '*/*', '34', '*/*',
      [], [''], '', [1]
    ].each do |value|
      it { is_expected.not_to allow_value(value) }
    end
  end
end

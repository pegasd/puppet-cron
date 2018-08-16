# frozen_string_literal: true

require 'spec_helper'

describe 'Cron::Hour' do
  describe 'accept integer values' do
    [0, 1, 2, 15, 23].each do |value|
      it { is_expected.to allow_value(value) }
    end
  end
  describe 'accept integer arrays' do
    [
      [0, 3, 7, 15, 22],
      [0, 3, 6, 9, 12, 15, 18, 21],
      [0, 12],
      [1, 2, 3, 4],
    ].each do |value|
      it { is_expected.to allow_value(value) }
    end
  end
  describe 'accept expressions like *, */2, 1-23/2, 11-23' do
    ['*', '0-5', '11-23', '5-11', '1-23', '19-22', '*/2', '*/23', '*/11', '1-23/2', '12-23/3', '2-20/4'].each do |value|
      it { is_expected.to allow_value(value) }
    end
  end
  describe 'accept arrays of valid expressions' do
    [
      ['0-5', '18-23'],
      ['*/5', '*/2'],
      ['*/5', 3],
      ['0-5', 23],
      ['*/5', '5-7', 23],
    ].each do |value|
      it { is_expected.to allow_value(value) }
    end
  end
  describe 'reject incorrect values' do
    [
      '00-05', '0-05', '*/0', '*/1', '*/24', '24', 24, -1,
      '2-23/24', '*/*', '34', [], [''], '', [1],
      ['*', 1], ['1-23/2', 1]
    ].each do |value|
      it { is_expected.not_to allow_value(value) }
    end
  end
end

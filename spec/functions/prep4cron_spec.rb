describe 'cron::prep4cron' do
  context 'return sorted unique arrays' do
    {
      [1, 2, 3, 4]     => [1, 2, 3, 4],
      [1, 5, 1]        => [1, 5],
      [1, 3, 5, 17, 2] => [1, 3, 5, 17, 2],
      [20, 40, 0]      => [20, 40, 0],
      ['0-5', 23]      => ['0-5', 23],
      ['0-6', '0-6']   => ['0-6'],
    }.each do |cron_value, cron_result|

      it { is_expected.to run.with_params(cron_value).and_return(cron_result) }

    end
  end

  context 'return integers and strings unchanged' do
    [
      0, 00001, 25, 50,
      '*', '*/2', '15-20/7', '10-40',
    ].each do |cron_value|

      it { is_expected.to run.with_params(cron_value).and_return(cron_value) }

    end
  end

  context 'fail with arrays of string or an empty string' do
    [
      '',
      %w(1 2 3),
      %w(0 12 24 36 48),
    ].each do |cron_value|

      it { is_expected.to run.with_params(cron_value).and_raise_error(ArgumentError) }

    end
  end

  context 'fail with negatives and large values' do
    [-1, 61, 31337].each do |cron_value|

      it { is_expected.to run.with_params(cron_value).and_raise_error(ArgumentError) }

    end
  end

end

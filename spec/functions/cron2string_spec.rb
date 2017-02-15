describe 'cron::cron2string' do
  context 'pass with integers' do
    { 0     => '0',
      00001 => '1',
      25    => '25',
      50    => '50',
    }.each do |cron_value, cron_result|

      it { is_expected.to run.with_params(cron_value).and_return(cron_result) }

    end

    context 'fail with negatives and large values' do
      [-1, 61, 31337].each do |cron_value|

        it { is_expected.to run.with_params(cron_value).and_raise_error(ArgumentError) }

      end
    end

    context 'pass with strings' do
      %w(* */2 15-20/7 10-40).each do |cron_value|

        it { is_expected.to run.with_params(cron_value).and_return(cron_value) }

      end
    end

    context 'pass with arrays of integers' do
      {
        [1, 5, 1]        => '1,5',
        [1, 3, 5, 17, 2] => '1,2,3,5,17',
        [20, 40, 0]      => '0,20,40',
      }.each do |cron_value, cron_result|

        it { is_expected.to run.with_params(cron_value).and_return(cron_result) }

      end
    end

    context 'fail with arrays of strings or an empty string' do
      [
        '',
        %w(),
        %w(0),
        %w(1),
        %w(1 2 3),
        %w(0 12 24 36 48),
      ].each do |cron_value|

        it { is_expected.to run.with_params(cron_value).and_raise_error(ArgumentError) }

      end
    end

  end
end
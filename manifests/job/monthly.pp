define cron::job::monthly (
  Cron::Command  $command,
  Cron::Minute   $minute   = 0,
  Cron::Hour     $hour     = 0,
  Cron::Monthday $monthday = 1,
) {

  cron::job { $title:
    command  => $command,
    minute   => $minute,
    hour     => $hour,
    monthday => $monthday,
    month    => '*',
    weekday  => '*',
  }

}

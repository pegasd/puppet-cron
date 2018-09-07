define cron::job::weekly (
  Cron::Command $command,
  Cron::Minute  $minute  = 0,
  Cron::Hour    $hour    = 0,
  Cron::Weekday $weekday = 0,
) {

  cron::job { $title:
    command  => $command,
    minute   => $minute,
    hour     => $hour,
    monthday => '*',
    month    => '*',
    weekday  => $weekday,
  }

}

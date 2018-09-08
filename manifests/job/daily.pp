define cron::job::daily (
  Cron::Command $command,
  Cron::Minute  $minute = 0,
  Cron::Hour    $hour   = 0,
  Cron::User    $user   = 'root',
) {

  cron::job { $title:
    command  => $command,
    minute   => $minute,
    hour     => $hour,
    monthday => '*',
    month    => '*',
    weekday  => '*',
    user     => $user,
  }

}

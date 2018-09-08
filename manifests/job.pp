# Cron job defined type with a bit of magic dust sprinkled all over.
#
# @example Consider cron job declaration using built-in type
#   cron { 'my_job':
#     minute => 0,
#     hour   => 3,
#   }
#
# @example This differs in that it manages *all* time values by default
#   cron::job { 'my_job':
#     minute => 0,
#     hour   => 3,
#   }
#
# @example Simple cron job that runs every minute
#   cron::job { 'ping-host':
#     command => '/usr/local/bin/my-host-pinger',
#   }
#
# @example More advanced declaration
#   cron::job { 'my-backup':
#     command => '/usr/local/bin/my-backup',
#     hour    => [ 0, 12 ],
#     minute  => '*/10';
#   }
#
# @param command Command path to be executed
# @param user The user who owns the cron job
# @param minute Cron minute
# @param hour Cron hour
# @param monthday Cron monthday
# @param month Cron month
# @param weekday Cron weekday
define cron::job (
  Cron::Command  $command,
  Cron::User     $user     = 'root',
  Cron::Minute   $minute   = '*',
  Cron::Hour     $hour     = '*',
  Cron::Monthday $monthday = '*',
  Cron::Month    $month    = '*',
  Cron::Weekday  $weekday  = '*',
) {

  include cron

  cron { $title:
    ensure   => present,
    user     => $user,
    command  => $command,
    minute   => $minute,
    hour     => $hour,
    monthday => $monthday,
    month    => $month,
    weekday  => $weekday,
  }

}

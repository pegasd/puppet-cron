# Manage weekly cron jobs.
#
# @param command Command path to be executed
# @param minute Cron minute
# @param hour Cron hour
# @param weekday Cron weekday
# @param user The user who owns the cron job
define cron::job::weekly (
  Cron::Command $command,
  Cron::Ensure  $ensure  = present,
  Cron::Minute  $minute  = 0,
  Cron::Hour    $hour    = 0,
  Cron::Weekday $weekday = 0,
  Cron::User    $user    = 'root',
) {

  cron::job { $title:
    ensure   => $ensure,
    command  => $command,
    minute   => $minute,
    hour     => $hour,
    monthday => '*',
    month    => '*',
    weekday  => $weekday,
    user     => $user,
  }

}

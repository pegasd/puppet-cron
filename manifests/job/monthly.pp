# Manage weekly cron jobs.
#
# @param command Command path to be executed
# @param ensure Cron job state
# @param minute Cron minute
# @param hour Cron hour
# @param monthday Cron monthday
# @param user The user who owns the cron job
define cron::job::monthly (
  Cron::Command  $command,
  Cron::Ensure   $ensure   = present,
  Cron::Minute   $minute   = 0,
  Cron::Hour     $hour     = 0,
  Cron::Monthday $monthday = 1,
  Cron::User     $user     = 'root',
) {
  cron::job { $title:
    ensure   => $ensure,
    command  => $command,
    minute   => $minute,
    hour     => $hour,
    monthday => $monthday,
    month    => '*',
    weekday  => '*',
    user     => $user,
  }
}

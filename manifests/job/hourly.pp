# Manage hourly cron jobs.
#
# @param command Command path to be executed
# @param minute Cron minute
# @param user The user who owns the cron job
define cron::job::hourly (
  Cron::Command $command,
  Cron::Minute  $minute = 0,
  Cron::User    $user   = 'root',
) {

  cron::job { $title:
    command  => $command,
    minute   => $minute,
    hour     => '*',
    monthday => '*',
    month    => '*',
    weekday  => '*',
    user     => $user,
  }

}

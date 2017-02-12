# cron job resource
#
# @author Eugene Piven <epiven@gmail.com>
#
# @example Declaring cron jobs
#   cron::job {
#     'ping-host':
#       command => '/usr/local/bin/my-host-pinger';
#     'my-backup':
#       command => '/usr/local/bin/my-backup',
#       hour    => [ 0, 12 ],
#       minute  => '*/10';
#   }
#
# @param command Command path to be executed
# @param user The user who owns the cron job
# @param minute Cron minute
# @param hour Cron hour
# @param monthday Cron monthday
# @param month Cron month
# @param weekday Cron weekday
# @param mode Cron job file permissions, which is located at /etc/cron.d/JOB_NAME
define cron::job (
  String                 $command,
  String                 $user     = 'root',
  Cron::Minute           $minute   = '*',
  Cron::Hour             $hour     = '*',
  Cron::Monthday         $monthday = '*',
  Cron::Month            $month    = '*',
  Cron::Weekday          $weekday  = '*',
  Pattern[/^0[0-7]{3}$/] $mode     = '0644',
) {

  file { "/etc/cron.d/${title}":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => $mode,
    content => epp('cron/job.epp', {
      name     => $title,
      minute   => $minute,
      hour     => $hour,
      monthday => $monthday,
      month    => $month,
      weekday  => $weekday,
      user     => $user,
      command  => $command,
    }),
  }

}

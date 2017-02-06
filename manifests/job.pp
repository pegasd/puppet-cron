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
  String                                    $command,
  String                                    $user     = 'root',
  Variant[Integer[0, 59], String,
    Array[Variant[Integer[0, 59], String]]] $minute   = '*',
  Variant[Integer[0, 23], String,
    Array[Variant[Integer[0, 23], String]]] $hour     = '*',
  Variant[Integer[1, 31], String,
    Array[Variant[Integer[1, 31], String]]] $monthday = '*',
  Variant[Integer[1, 12], String,
    Array[Variant[Integer[1, 12], String]]] $month    = '*',
  Variant[Integer[0, 6], String,
    Array[Variant[Integer[0, 6], String]]]  $weekday  = '*',
  Pattern[/^[0-7]{4}$/]                     $mode     = '0644',
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

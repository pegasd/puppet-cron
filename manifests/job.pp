# Cron::job resource type.
#
# @author Evgeny Piven <epiven@gmail.com>
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
# @param mode Mode of /etc/cron.d/job_${title} file
# @param minute Cron minute
# @param hour Cron hour
# @param monthday Cron monthday
# @param month Cron month
# @param weekday Cron weekday

define cron::job (
  String                             $command,
  String[4, 4]                       $mode            = '0644',
  String                             $user            = 'root',
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
) {

  require ::cron

  file { "cron-job_${title}":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => $mode,
    path    => "/etc/cron.d/job_${title}",
    content => epp('cron/job.epp', {
      name     => $name,
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
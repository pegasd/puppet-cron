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
define cron::job (
  String                $command,
  String[4, 4]          $mode = '0644',
  String                $user = 'root',
) {

  file { "cron-job_${name}":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => $mode,
    content => epp('cron/job.epp'),
  }

}
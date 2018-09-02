define cron::hourly (
  Cron::Command $command,
) {

  cron::job { $title:
    command => $command,
  }

}

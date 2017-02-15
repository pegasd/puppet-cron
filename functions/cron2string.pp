function cron::cron2string (
  Variant[
    Cron::Minute,
    Cron::Hour,
    Cron::Monthday,
    Cron::Month,
    Cron::Weekday
  ] $cron_value = '',
) {

  # Can we please get a profiler here?
  join(sort(unique(any2array($cron_value))), ',')

}
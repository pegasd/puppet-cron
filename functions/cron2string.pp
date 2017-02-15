# cron::cron2string function
#
# This function converts any cron timing value to a string similar to these examples:
# '*', '5', '17,34', '*/2', '2-59/10', '
#
# @param cron_value A variant of any of cron's internal timing structures (minute, hour, monthday, month, weekday)
# @return [String] Representation of the cron time in a proper string format ready to be plugged into a template
function cron::cron2string (
  Variant[
    Cron::Minute,
    Cron::Hour,
    Cron::Monthday,
    Cron::Month,
    Cron::Weekday
  ] $cron_value = '*',
) {

  # Can we please get a profiler here?
  join(sort(unique(any2array($cron_value))), ',')

}
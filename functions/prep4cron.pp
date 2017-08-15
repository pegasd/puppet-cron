# cron::prep4cron function
#
# This functions prepares any cron::job custom timing value to be
# used as Puppet internal cron's resource argument
#
# @param cron_value A variant of any of cron's internal timing structures (minute, hour, monthday, month, weekday)
# @return [String, Integer, Array[Variant[Integer, String]]] Representation of the cron time value in a proper format suited for
#   internal Puppet's cron resource.
function cron::prep4cron (
  Variant[
    Cron::Minute,
    Cron::Hour,
    Cron::Monthday,
    Cron::Month,
    Cron::Weekday
  ] $cron_value = '*',
) {

  if $cron_value.is_a(Array) {

    unique($cron_value)

  } else {

    $cron_value

  }

}

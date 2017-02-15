# Cron::Weekday type
#
# Can and should be reused in higher-level classes
# Stricture than puppet's cron::weekday type
type Cron::Weekday = Variant[
  Integer[0, 6],
  Array[Integer[0, 6], 1],
  # Supports expressions like *, */2, 0-4/2, 0-4
  Pattern[/^(\*|[0-6]-[0-6])(\/[2-6])?$/],
]
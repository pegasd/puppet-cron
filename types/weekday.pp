# Cron::Weekday type
#
# Can and should be reused in higher-level classes
# Stricture than puppet's cron::weekday type
type Cron::Weekday = Variant[
  Integer[0, 6],
  Array[Integer[0, 6]],
  Enum['*'],
]
# Cron::Monthday type
#
# Can and should be reused in higher-level classes
# Stricter than puppet's cron::monthday type
type Cron::Monthday = Variant[
  Integer[1, 31],
  Array[Integer[1, 31], 1],
  Enum['*'],
]
# Cron::Minute type
#
# Can and should be reused in higher-level classes
# Stricter than puppet's cron::minute type
type Cron::Minute = Variant[
  Integer[0, 59],
  Array[Integer[0, 59], 1],
  # Supports expressions like *, */5, 1-59/5, 10-40
  Pattern[/^(\*|[0-5]?[0-9]-[0-5]?[0-9])(\/([2-9]|[1-5][0-9]))?$/],
]
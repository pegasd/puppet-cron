# Cron::Month type
#
# Can and should be reused in higher-level classes
# Stricter than puppet's cron::month type
type Cron::Month = Variant[
  Integer[1, 12],
  Array[Integer[1, 12], 2],
  # Supports *, */2, */11
  Pattern[/^\*(\/([2-9]|1[0-1]))?$/],
]

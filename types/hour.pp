# Cron::Hour type
#
# Can and should be reused in higher-level classes
# Stricter than puppet's cron::hour type
type Cron::Hour = Variant[
  Integer[0, 23],
  Array[Integer[0, 23]],
  # Supports expressions like *, */2, 1-23/2, 11-23
  Pattern[/^(\*|(1?[0-9]|2[0-3])-(1?[0-9]|2[0-3]))(\/([2-9]|1[0-9]|2[0-3]))?$/],
]
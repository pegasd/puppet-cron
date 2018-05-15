# Stricter `cron::job::weekday`.
type Cron::Weekday = Variant[
  Integer[0, 6],
  Array[Integer[0, 6], 2],
  # Supports expressions like *, */2, 0-4/2, 0-4
  Pattern[/\A(\*|[0-6]-[0-6])(\/[2-6])?\z/],
]

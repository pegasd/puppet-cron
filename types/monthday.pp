# Can and should be reused in higher-level classes
# Stricter than puppet's cron::monthday type
type Cron::Monthday = Variant[
  Integer[1, 31],
  Array[Integer[1, 31], 2],
  # *, */2, */30
  Pattern[/\A\*(\/([2-9]|[1-2][0-9]|30))?\z/],
]

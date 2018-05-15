# Stricter `cron::job::month`.
type Cron::Month = Variant[
  Integer[1, 12],
  Array[Integer[1, 12], 2],
  # Supports *, */2, */11
  Pattern[/\A\*(\/([2-9]|1[0-1]))?\z/],
]

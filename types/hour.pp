# Stricter `cron::job::hour`.
type Cron::Hour = Variant[
  Integer[0, 23],
  Array[Variant[
    Integer[0, 23],
    # Ranges like '0-12', '5-8', etc.
    Pattern[/\A(1?\d|2[0-3])-(1?\d|2[0-3])\z/],
    # Constructs like '*/5', '*/2'
    Pattern[/\A\*\/(1?\d|2[0-3])\z/],
  ], 2],
  # Supports expressions like *, */2, 1-23/2, 11-23
  Pattern[/\A(\*|(1?[0-9]|2[0-3])-(1?[0-9]|2[0-3]))(\/([2-9]|1[0-9]|2[0-3]))?\z/],
]

# Cron::Minute type
#
# Can and should be reused in higher-level classes
# Stricter than puppet's cron::minute type
type Cron::Minute = Variant[
  Integer[0, 59],
  Array[Variant[
    Integer[0, 59],
    # Ranges like '0-37', '30-59', etc.
    Pattern[/^[0-5]?\d-[0-5]?\d$/],
    # Patterns like '*/2'
    Pattern[/^\*\/([2-9]|[1-5]\d)$/],
  ], 2],
  # Supports expressions like *, */5, 1-59/5, 10-40
  Pattern[/^(\*|[0-5]?\d-[0-5]?\d)(\/([2-9]|[1-5]\d))?$/],
]

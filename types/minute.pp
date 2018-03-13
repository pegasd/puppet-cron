# Can and should be reused in higher-level classes
# Stricter than puppet's cron::minute type
type Cron::Minute = Variant[
  Integer[0, 59],
  Array[Variant[
    Integer[0, 59],
    # Ranges like '0-37', '30-59', etc.
    Pattern[/\A[0-5]?\d-[0-5]?\d\z/],
    # Patterns like '*/2'
    Pattern[/\A\*\/([2-9]|[1-5]\d)\z/],
  ], 2],
  # Supports expressions like *, */5, 1-59/5, 10-40
  Pattern[/\A(\*|[0-5]?\d-[0-5]?\d)(\/([2-9]|[1-5]\d))?\z/],
]

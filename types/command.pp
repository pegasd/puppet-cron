# Prevent newlines in cron::job::command parameter.
type Cron::Command = Pattern[/\A[^\n]+\z/]

# Used for `cron::job::command` parameter.
# Does not allow newline characters (which breaks crontab).
type Cron::Command = Pattern[/\A[^\n]+\z/]

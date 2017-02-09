# @api private
# This class handles cron configuration files.
# Avoid modifying and using private classes directly.
class cron::config {

  file { '/etc/cron.d':
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
    owner   => 'root',
    group   => 'root',
    mode    => $::cron::dir_mode,
  }

}

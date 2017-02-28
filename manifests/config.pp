# @api private
# This is where all the magic happens.
# Purge unmanaged cron jobs and also, optionally, purge /etc/cron.d directory
class cron::config {

  resources { 'cron':
    purge => true,
  }

  if $::cron::purge_crond {
    file { '/etc/cron.d':
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      recurse => true,
      purge   => true,
      force   => true,
    }
  }

}

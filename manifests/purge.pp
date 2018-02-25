# This is where all the purging magic happens.
# Purge unmanaged cron jobs and also, optionally, purge /etc/cron.d directory
#
# @api private
class cron::purge {

  $noop = $::cron::purge_noop ? {
    false => undef,
    true  => true,
  }

  resources { 'cron':
    purge => true,
    noop  => $noop,
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
      noop    => $noop,
    }
  }

}

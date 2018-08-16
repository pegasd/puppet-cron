# This is where all the purging magic happens.
# Purge unmanaged cron jobs and also, optionally, purge `/etc/cron.d` directory.
#
# @api private
class cron::purge {

  $noop = if $::cron::purge_noop {
    true
  } else {
    undef
  }

  if $::cron::purge_cron {
    resources { 'cron':
      purge => true,
      noop  => $noop,
    }
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

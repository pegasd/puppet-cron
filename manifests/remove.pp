# This class handles removal of all cron-related resources.
#
# @api private
class cron::remove {
  service { 'cron':
    ensure => stopped,
  }

  package { 'cron':
    ensure => absent,
  }

  file {
    [
      '/etc/cron.d',
      $cron::deny_file,
      $cron::allow_file,
    ]:
      ensure => absent,
      force  => true,
  }
}

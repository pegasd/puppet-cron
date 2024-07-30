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
      '/etc/cron.deny',
      '/etc/cron.allow',
    ]:
      ensure => absent,
      force  => true,
  }
}
